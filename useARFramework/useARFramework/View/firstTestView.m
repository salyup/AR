//
//  firstTestView.m
//  useARFramework
//
//  Created by ply on 21/12/20.
//  Copyright © ABC. All rights reserved.
//

#import "firstTestView.h"
#import <VRARFramework/ARController.h>
#import "UIView+UIViewController.h"

@implementation firstTestView
-(instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        self.frame = CGRectMake(20, 80, 100, 50);
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        [button addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}


- (void)jump:(id)sender {
    NSString *resourceBundlePath = [[NSBundle mainBundle] pathForResource:@"VRARFramework" ofType:@"framework"];
    NSBundle* languageBundle = [NSBundle bundleWithPath:resourceBundlePath];
    [languageBundle load];
    NSLog(@"The bundle desc: %@",[languageBundle description]);
    NSArray *imageUrlArray = [NSArray arrayWithObjects:@"http://192.168.84.239:8088/public/js_video.jpeg", @"http://192.168.84.239:8088/public/ai_model.jpeg",@"http://192.168.84.239:8088/public/java_model.jpeg",@"http://192.168.84.239:8088/public/test_model.jpeg",@"http://192.168.84.239:8088/public/cube_model.jpeg",nil];
    ARController *playerViewController = [[ARController alloc] initWithResourceURL:imageUrlArray];

    [self.navigationController pushViewController:playerViewController animated:YES];
}

@end
