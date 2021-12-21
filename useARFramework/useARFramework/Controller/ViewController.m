//
//  ViewController.m
//  useARFramework
//
//  Created by CrabMan on 16/5/18.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "firstTestView.h"
#import "secondViewController.h"
#import <VRARFramework/ARController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    firstTestView *firstView = [[firstTestView alloc]init];
    
    
    NSString *resourceBundlePath = [[NSBundle mainBundle] pathForResource:@"VRARFramework" ofType:@"framework"];
    NSBundle* languageBundle = [NSBundle bundleWithPath:resourceBundlePath];
    [languageBundle load];
    NSLog(@"The bundle desc: %@",[languageBundle description]);
    NSArray *imageUrlArray = [NSArray arrayWithObjects:@"http://192.168.84.239:8088/public/js_video.jpeg", @"http://192.168.84.239:8088/public/ai_model.jpeg",@"http://192.168.84.239:8088/public/java_model.jpeg",@"http://192.168.84.239:8088/public/test_model.jpeg",@"http://192.168.84.239:8088/public/cube_model.jpeg",nil];
    ARController *playerViewController = [[ARController alloc] initWithResourceURL:imageUrlArray];

    firstView.block = ^{
        [self.navigationController pushViewController:playerViewController animated:YES];
    };
    
    [self.view addSubview:firstView];
    
        
    
}

 - (void)viewDidUnload {
     [super viewDidUnload];
     NSLog(@"312428974837498274");
 }

- (void)jump {
    
    [self.navigationController pushViewController:[secondViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
