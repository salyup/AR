//
//  ARController.m
//  ARController
//
//  Created by 平林艳 on 2021/12/21.
//  Copyright © 2021 ABC. All rights reserved.
//

#import "ARController.h"
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

// Delegates
#import "ARPlaneRendererDelegate.h"
#import "SceneGestureRecognizerDelegate.h"

// Utils
#import "Constants.h"
#import "SettingsManager.h"

// Categories
#import "UIViewController+Helpers.h"
#import "UrlService.h"
#import "DownloadResources.h"

@interface ARController ()<ARSCNViewDelegate>
@property (nonatomic, strong) ARSCNView *sceneView;
@property (nonatomic, strong) ARPlaneRendererDelegate *planeRendererDelegate;
@property (nonatomic, strong) SceneGestureRecognizerDelegate *sceneGestureRecognizerDelegate;
@property (nonatomic, strong) NSArray *imageUrlArray;

@end

static ARWorldTrackingConfiguration *arconfig;

@implementation ARController

- (instancetype)initWithResourceURL:(NSArray *)imageUrlArray {
    self = [super init];
    if (self) {
        self.imageUrlArray = imageUrlArray;
    }
    return self;
}

#pragma mark - UIViewController delegate methods
  
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!ARConfiguration.isSupported) {
        [self showMessage:@"ARConfiguration is not supported."];
    }else {
        [self initUI];
        [self setupConfiguration];

    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
//    [self.sceneView.session runWithConfiguration:configuration];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Pause the view's session
    [self.sceneView.session pause];
}


#pragma mark ========================= 初始化方法 ========================
- (void)initUI {
    ARSCNView *sceneView1 = [ARSCNView new];
    self.sceneView = sceneView1;
    self.view = sceneView1;

    self.planeRendererDelegate = [ARPlaneRendererDelegate new];
    self.sceneView.delegate = self.planeRendererDelegate;
    self.sceneView.showsStatistics = YES;

    SCNScene *scene = [SCNScene scene];
    self.sceneView.scene = scene;
    self.planeRendererDelegate.sceneView = self.sceneView;
    self.sceneGestureRecognizerDelegate = [[SceneGestureRecognizerDelegate alloc] initWithSceneView:self.sceneView];
    

}


- (void)setupConfiguration {
    if (ARConfiguration.isSupported) {
        NSLog(@"[%s] congratulations!!! ARConfiguration is supported.", __FUNCTION__);
        ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
        configuration.planeDetection = ARPlaneDetectionHorizontal;
        self.sceneView.automaticallyUpdatesLighting = YES;
        [UrlService loadDynamicImageReference:self.imageUrlArray withConfig:configuration];
        arconfig = configuration;
        [self.sceneView.session runWithConfiguration:configuration];
        [SettingsManager instance].scaleAllowed = YES;
        [SettingsManager instance].rotationAllowed = YES;

        
    } else {
        NSLog(@"[%s] ARConfiguration is not supported.", __FUNCTION__);
    }
}

+ (ARWorldTrackingConfiguration *)getARConfig {
    return arconfig;
}

@end
