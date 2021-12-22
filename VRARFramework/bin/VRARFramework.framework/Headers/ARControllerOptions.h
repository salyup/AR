//
//  ARControllerOptions.h
//  ARControllerOptions
//
//  Created by 平林艳 on 2021/12/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ARControllerOptions : NSObject

@property (nonatomic, strong) NSArray *imageUrlArray;
@property (nonatomic, strong) NSArray *modelUrlArray;
@property (nonatomic, strong) NSArray *movieUrlArray;
@property (nonatomic) BOOL showPlanes;
@property (nonatomic) BOOL vibrateOnTouch;
@property (nonatomic) BOOL animateOnTouch;
@property (nonatomic) BOOL scaleAllowed;
@property (nonatomic) BOOL rotationAllowed;
@property (nonatomic) BOOL repositionAllowed;

@end

NS_ASSUME_NONNULL_END
