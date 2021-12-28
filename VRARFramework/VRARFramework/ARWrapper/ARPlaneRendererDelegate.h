//
//  ARPlaneRendererDelegate.h
//  ARPlaneRendererDelegate
//
//  Created by 平林艳 on 2021/12/21.
//  Copyright © 2021 ABC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface ARPlaneRendererDelegate : NSObject <ARSCNViewDelegate>
@property (strong,nonatomic) ARSCNView *sceneView;
- (instancetype)initWithModelScale:(float)nodescale;
@end

NS_ASSUME_NONNULL_END
