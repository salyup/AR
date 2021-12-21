//
//  ViewController.m
//  useARFramework
//
//  Created by ply on 16/5/18.
//  Copyright © ABC. All rights reserved.
//

#import "ViewController.h"
#import "firstTestView.h"
#import "secondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    firstTestView *firstView = [[firstTestView alloc]init];
    [self.view addSubview:firstView];
    
}

 - (void)viewDidUnload {
     [super viewDidUnload];
     NSLog(@"312428974837498274");
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
