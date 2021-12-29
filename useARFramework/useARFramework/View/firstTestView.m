//
//  firstTestView.m
//  useARFramework
//
//  Created by ply on 21/12/20.
//  Copyright © ABC. All rights reserved.
//

#import "firstTestView.h"
#import <VRARFramework/ARController.h>
#import <VRARFramework/ARControllerOptions.h>
#import "UIView+UIViewController.h"

@implementation firstTestView
-(instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 150, [UIScreen mainScreen].bounds.size.width-60, 44);
        button.backgroundColor = [UIColor blueColor];
        [button setTitle:@"AR扫一扫" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toarpage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}

- (void)toarpage {
    NSArray *imageUrlArray = [NSArray arrayWithObjects:@"http://192.168.84.239:8088/public/js_video.jpeg", @"http://192.168.84.239:8088/public/ai_model.jpeg",@"http://192.168.84.239:8088/public/java_model.jpeg",@"http://192.168.84.239:8088/public/test_model.jpeg",@"http://192.168.84.239:8088/public/cube_model.jpeg",@"http://192.168.84.239:8088/public/seed_model.jpeg",nil];
    // NSArray *imageUrlArray = [NSArray arrayWithObjects:@"http://192.168.84.239:8088/public/seed_model.jpeg",nil];
    // 想要识别什么图片，就传入图片地址（后续改为模块号之类的）
    ARControllerOptions *option = [[ARControllerOptions alloc] init];
    option.imageUrlArray = imageUrlArray;
    option.scaleAllowed = YES;
    option.rotationAllowed = YES;
    option.modelScale = 0.05;
    ARController *playerViewController = [[ARController alloc] initWithOptions:option];
    [self.navigationController pushViewController:playerViewController animated:YES];
}

- (void)jump:(id)sender {
//    NSString *resourceBundlePath = [[NSBundle mainBundle] pathForResource:@"VRARFramework" ofType:@"framework"];
//    NSBundle* languageBundle = [NSBundle bundleWithPath:resourceBundlePath];
//    [languageBundle load];
//    NSLog(@"The bundle desc: %@",[languageBundle description]);
}

@end
