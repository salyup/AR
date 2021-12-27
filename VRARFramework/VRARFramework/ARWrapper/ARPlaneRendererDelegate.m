//
//  ARPlaneRendererDelegate.m
//  ARPlaneRendererDelegate
//
//  Created by 平林艳 on 2021/12/21.
//  Copyright © 2021 ABC. All rights reserved.
//


@import ARKit;

#import "ARPlaneRendererDelegate.h"

// Nodes
#import "PlaneRendererNode.h"
#import "ARNode.h"

// Utils
#import "Constants.h"
#import "SettingsManager.h"
#import "MediaPlayerNode.h"
#import "ARController.h"

@interface ARPlaneRendererDelegate ()

@property (nonatomic, strong) NSMutableDictionary *planes;

@end

@implementation ARPlaneRendererDelegate

- (instancetype)init {
    self = [super init];

    if (self) {
        self.planes = [NSMutableDictionary new];
        [self subscribeForNotifications];
    }

    return self;
}

#pragma mark - ARSCNViewDelegate methods

- (void)renderer:(id <SCNSceneRenderer>)renderer
      didAddNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {

   if([anchor isKindOfClass:[ARImageAnchor class]]) {
       ARImageAnchor *anchorNew = anchor;
       simd_float4 column = anchor.transform.columns[3];
       ARWorldTrackingConfiguration *config = [ARController getARConfig];
       // 比对config里的detectionImages和anchorNew.referenceImage是否相同，相同则找到同名的模型渲染------
       NSArray *deImageArray = config.detectionImages.allObjects;
       for (ARReferenceImage *arReferenceImage in deImageArray) {
           if([arReferenceImage.name isEqualToString: anchorNew.referenceImage.name]){
               NSLog(@"[%s]got the same img：%@", __FUNCTION__, arReferenceImage.name);
               NSArray *array = [arReferenceImage.name componentsSeparatedByString:@"_"];
               NSString *type = array[array.count-1];
               NSString *reName = array[0];
               // 后续应改为文件名是mov_****播放视频或者model_*****创建模型
               if([type isEqualToString:FileVideo]){
                   // 创建播放视频node
                   NSString *videlurl = [NSString stringWithFormat:@"%@%@%@",@"http://192.168.84.239:8088/public/",reName,@".mp4"];
                   NSArray<NSURL *> *playlist = [NSArray arrayWithObjects: [NSURL URLWithString:videlurl], nil];
                   MediaPlayerNode *mediaPlayerNode = [[MediaPlayerNode alloc] initWithPlaylist:playlist direction:dVertical];
                   mediaPlayerNode.position = SCNVector3Make(column.x, column.y, column.z);
                   [mediaPlayerNode play];
                   [self.sceneView.scene.rootNode addChildNode:mediaPlayerNode];
               }else if([type isEqualToString:fileModel]){
                   // 创建模型展示node
                   ARNode *arNode = [[ARNode alloc] initWithModelName:reName];
                   arNode.name = objName;
                   arNode.position = SCNVector3Make(column.x, column.y, column.z);
                   [self.sceneView.scene.rootNode addChildNode:arNode];
               }

               break;
           }
       }


   }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer
   didUpdateNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {
    PlaneRendererNode *plane = [self.planes objectForKey:anchor.identifier];
    if (plane == nil) {
        return;
    }

    [plane update:(ARPlaneAnchor *)anchor];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer
   didRemoveNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {
    [self.planes removeObjectForKey:anchor.identifier];
}

#pragma mark - Helper methods

- (void)subscribeForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPlanes:)
                                                 name:kNotificationShowPlanes
                                               object:nil];
}

- (void)showPlanes:(NSNotification *)notification {
    for (PlaneRendererNode *plane in [self.planes allValues]) {
        if ([SettingsManager instance].showPlanes) {
            [plane show];
        } else {
            [plane hide];
        }
    }
}

@end
