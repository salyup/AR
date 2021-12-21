//
//  ARNode.h
//  ARNode
//
//  Created by 平林艳 on 2021/12/1.
//  Copyright © 2021 Maxim Makhun. All rights reserved.
//

@import SceneKit;
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARNode : SCNNode
- (instancetype)initWithModelName:(NSString *)name ;
@end

NS_ASSUME_NONNULL_END
