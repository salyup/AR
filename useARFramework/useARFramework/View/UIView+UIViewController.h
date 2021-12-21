//
//  UIView+UIViewController.h
//  useARFramework
//
//  Created by ply on 16/5/18.
//  Copyright © ABC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewController)

@property (nonatomic,strong) UINavigationController *navigationController;

- (UIViewController *)viewController ;
@end
