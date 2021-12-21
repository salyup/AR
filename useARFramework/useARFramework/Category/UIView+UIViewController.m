//
//  UIView+UIViewController.m
//  useARFramework
//
//  Created by ply on 21/12/20.
//  Copyright © ABC. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

-(UINavigationController *)navigationController {
   
    UIViewController *vc = [self viewController];
    return vc.navigationController;

}
- (UIViewController *)viewController {
    //通过响应者链，获得view所在的视图控制器
    UIResponder *next = self.nextResponder;
    do {
        //判断响应者对象是否是视图控制器类型
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }while(next != nil);
    
    return nil;
}

@end
