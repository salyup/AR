//
//  TVNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 10/1/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

// Nodes
#import "TVNode.h"
#include "VideoRendererNode.h"
#import "ControlNode.h"

// Utils
#import "Constants.h"

// Categories
#import "SCNNode+Helpers.h"
#import "SCNMaterial+Contents.h"
@import ModelIO;
@import SceneKit.ModelIO;

@interface TVNode ()

@property (nonatomic, strong) SCNNode *tvNode;
@property (nonatomic, strong) VideoRendererNode *videoRendererNode;

@end

@implementation TVNode

//- (instancetype)init {
//    self = [super init];
//
//    if (self) {
//        [self createTvNode];
//        [self createVideoRendererNode];
//    }
//
//    return self;
//}
- (instancetype)initWithdirection:(NSString *)direction {
    self = [self init];
    if (self) {
        [self createTvNode:direction];
        [self createVideoRendererNode];
    }
    return self;
}


- (void)createTvNode:(NSString *)direction{
    //    创建一个长方体，用于播放视频
    SCNNode *showNode = [SCNNode new];
    SCNBox * box = nil;
    if([direction isEqualToString:dVertical]){
        box = [SCNBox boxWithWidth:0.2 height:0.3 length:0.01 chamferRadius:0];
    }else {
        box = [SCNBox boxWithWidth:0.3 height:0.2 length:0.01 chamferRadius:0];
    }
    showNode.geometry = box;
    showNode.position = SCNVector3Make(0, 0, 0);
    self.tvNode = showNode;
    //    注释掉样例中使用scn方式渲染的代码
    //    SCNNode *tvNode1 = [[SCNScene sceneNamed:@"Art.scnassets/tv_scene.scn"].rootNode childNodeWithName:videoName recursively:NO];
    //    self.tvNode.geometry.firstMaterial.diffuse.contents = [[UIColor lightGrayColor] colorWithAlphaComponent:1.0f];
    self.tvNode.movabilityHint = SCNMovabilityHintFixed;
    self.tvNode.name = videoName;
    [self addChildNode:self.tvNode];
}

- (void)createVideoRendererNode {
    self.videoRendererNode = [[VideoRendererNode alloc] initWithParentNode:self.tvNode];
    [self.tvNode addChildNode:self.videoRendererNode];
}

- (void)setPlayer:(AVPlayer * )player {
    SCNMaterial *mainMaterial = [SCNMaterial materialWithColor:[UIColor blackColor]];
    
    [_player pause];
    [_player replaceCurrentItemWithPlayerItem:nil];
    
    if (player == nil) {
        self.videoRendererNode.geometry.firstMaterial = mainMaterial;
        _player = nil;
    } else {
        _player = player;
        //  视频材质应渲染在模型节点的materials内而不是子节点的materials内，之前的例子使用的scn模型，可能渲染方式不同（未经验证）
        self.tvNode.geometry.materials = @[[self materialWithPlayer:_player], mainMaterial, mainMaterial, mainMaterial, mainMaterial, mainMaterial];
        //    self.videoRendererNode.geometry.materials = @[[self materialWithPlayer:_player], mainMaterial, mainMaterial, mainMaterial, mainMaterial, mainMaterial];
        [_player play];
    }
}

#pragma mark - Helper methods

- (SCNMaterial *)materialWithPlayer:(AVPlayer *)player {
    SCNMaterial *material = [SCNMaterial new];
    material.diffuse.contents = player;

    return material;
}

@end
