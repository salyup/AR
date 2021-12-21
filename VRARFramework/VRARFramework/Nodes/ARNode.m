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

- (instancetype)initWithModelName:(NSString *)name {
    self = [self init];

    if (self) {
        [self createARNode:name];
    }
    
    return self;
}

- (void)createARNode:(NSString *)name {
    // 渲染obj模型
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *docpath  = [cachesPath stringByAppendingFormat:@"%@%@%@%@%@",@"/",modelFolderName,@"/",name,@".obj"];
    NSURL * url= [NSURL URLWithString:docpath];
    MDLAsset *mdlAsset = [[MDLAsset alloc] initWithURL:url];
    self.arNode = [SCNScene sceneWithMDLAsset:mdlAsset].rootNode.childNodes[0];
    self.arNode.movabilityHint = SCNMovabilityHintFixed;
    [self addChildNode:self.arNode];
}

@end
