//
//  ARController.h
//  ARController
//
//  Created by 平林艳 on 2021/12/21.
//  Copyright © 2021 ABC. All rights reserved.
//

@import UIKit;
@import SceneKit;
@import ARKit;

NS_ASSUME_NONNULL_BEGIN

@interface ARController : UIViewController

- (instancetype)initWithResourceURL:(NSArray *)imageUrlArray;
+ (ARWorldTrackingConfiguration *)getARConfig ;


@end

NS_ASSUME_NONNULL_END
