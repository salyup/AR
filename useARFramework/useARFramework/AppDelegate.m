//
//  AppDelegate.m
//  useARFramework
//
//  Created by ply on 21/12/20.
//  Copyright © ABC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <VRARFramework/DownloadResources.h>
#import <AVFoundation/AVFoundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CFNetwork/CFNetwork.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <CoreTelephony/CTCellularData.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    [_window makeKeyAndVisible];
    [self alertToEncourageCameraAccessInitially];
    [self getNetworkStatus];
    [NSThread detachNewThreadSelector:@selector(prepareARfile) toTarget:self withObject:nil];
    return YES;
}

-(void)alertToEncourageCameraAccessInitially{
    if([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            AVAuthorizationStatus status =[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusAuthorized){
            }else if(status == AVAuthorizationStatusDenied ||status ==AVAuthorizationStatusRestricted){//拒绝了权限
            }
        }];
    }
}
-(void)getNetworkStatus{

}

- (void)prepareARfile {
    //预先下载图片
    NSArray *imageUrlArray = [NSArray arrayWithObjects:@"http://192.168.84.239:8088/public/js_video.jpeg", @"http://192.168.84.239:8088/public/ai_model.jpeg",@"http://192.168.84.239:8088/public/java_model.jpeg",@"http://192.168.84.239:8088/public/test_model.jpeg",@"http://192.168.84.239:8088/public/cube_model.jpeg",@"http://192.168.84.239:8088/public/seed_model.jpeg",nil];
    NSArray *modelUrlArray = [NSArray arrayWithObjects:@"http://192.168.84.239:8088/public/ai.zip",@"http://192.168.84.239:8088/public/java.zip",@"http://192.168.84.239:8088/public/test.zip",@"http://192.168.84.239:8088/public/cube.zip",@"http://192.168.84.239:8088/public/seed.zip",nil];
    NSArray *movieUrlArray = nil;
    DownloadResources *downloadResources = [[DownloadResources alloc] init];
    NSString *reflag = [downloadResources downloadFile:imageUrlArray modelUrl:modelUrlArray movieUrl:movieUrlArray];
    if(![reflag isEqualToString:@"success"]){
        NSLog(@"download faild, please check network");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
