//
//  ARNode.m
//  ARNode
//
//  Created by 平林艳 on 2021/12/1.
//  Copyright © 2021 Maxim Makhun. All rights reserved.
//

#import "Constants.h"
#import "SCNNode+Helpers.h"
#import "ARNode.h"
@import ModelIO;
@import SceneKit.ModelIO;


@interface ARNode ()

@property (nonatomic, strong) SCNNode *arNode;

@end
@implementation ARNode

- (instancetype)initWithModelName:(NSString *)name nodeScale:(float)nodescale{
    self = [self init];

    if (self) {
        [self createARNode:name nodeScale:nodescale];
    }
    
    return self;
}

- (void)createARNode:(NSString *)name nodeScale:(float)nodescale{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 渲染dae模型
    NSString *unzippath  = [cachesPath stringByAppendingFormat:@"%@%@%@",@"/",modelFolderName,@"/"];
    NSString *newPath = [NSString stringWithFormat:@"%@%@",unzippath,name];
    SCNScene *scene = [SCNScene sceneWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@%@",newPath,name,@".dae"]] options:nil error:nil];
    self.arNode = scene.rootNode;
    self.arNode.movabilityHint = SCNMovabilityHintFixed;
    CGFloat pinchScaleX = nodescale * self.arNode.scale.x;
    CGFloat pinchScaleY = nodescale * self.arNode.scale.y;
    CGFloat pinchScaleZ = nodescale * self.arNode.scale.z;
    self.arNode.scale = SCNVector3Make(pinchScaleX, pinchScaleY, pinchScaleZ);
    [self addChildNode:self.arNode];
}

@end
