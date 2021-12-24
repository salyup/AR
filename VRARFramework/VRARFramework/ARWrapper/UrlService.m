//
//  UrlService.m
//  ARPlayer
//
//  Created by 徐长帆 on 2021/10/25.
//  Copyright © 2021 Maxim Makhun. All rights reserved.
//
@import UIKit;
@import ARKit;
#import "UrlService.h"
#import "Constants.h"
#import "DownloadResources.h"

static NSString * BASE_URL_FOR_UFILE = @"https://baidu.com?ufileId=";

@implementation UrlService
+ (NSArray<NSURL *> *) list:(NSArray<NSString *> *) ufileIds {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *ufileId in ufileIds) {
        [array addObject:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL_FOR_UFILE, ufileId]]];
    }
    return array;
}

+ (NSURL *) single:(NSString *) ufileid {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL_FOR_UFILE, ufileid]];
}

+(UIImage *) getImage:(NSString *)ufileid {
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL_FOR_UFILE, ufileid]]];
    return [UIImage imageWithData:data];
}

+(void) loadDynamicImageReference:(NSArray<NSString *> *) urls  withConfig:(ARWorldTrackingConfiguration *) config {
    CIImage *img ;
    CGImageRef ref;
    DownloadResources *downloadResources = [[DownloadResources alloc] init];
    NSMutableArray<ARReferenceImage *> *array = [NSMutableArray array];
    for(id url in urls){
        UIImage *image = [downloadResources loadLocalImage:url folderName:imageFolderName];
        NSData *imageData = UIImagePNGRepresentation(image);
        [self copyARfiles];
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *docpath1 = [cachesPath stringByAppendingFormat:@"%@%@%@",@"/",imageFolderName,@"/vrar_model.jpeg"];
        UIImage *uiimg1 = [UIImage imageWithContentsOfFile:docpath1];
        CGImageRef ref1 = uiimg1.CGImage;
        ARReferenceImage *arimg1 = [[ARReferenceImage alloc] initWithCGImage:ref1 orientation:kCGImagePropertyOrientationUp physicalWidth:0.2f];
        arimg1.name = @"vrar_model";
        [array addObject:arimg1];
        if (imageData != nil) {
            NSLog(@"[%s] imageData != nil.", __FUNCTION__);
            // use download data
            FileData *fdata = [FileData alloc];
            fdata = [downloadResources getImgsData:url folderName:imageFolderName uImg:image];
            img = [CIImage imageWithData: fdata.imgData];
            ref = [self convertCIImageToCGImage:img];
            ARReferenceImage *arimg = [[ARReferenceImage alloc] initWithCGImage:ref orientation:kCGImagePropertyOrientationUp physicalWidth:0.2f];
            arimg.name = fdata.imgName;
            [array addObject:arimg];
        }
        config.detectionImages = [NSSet setWithArray:array];
    }
}

+(void)copyARfiles {
    DownloadResources *downloadResources = [[DownloadResources alloc] init];
    [downloadResources resourcesFilePath:@"" folderName:imageFolderName resourcesType:fileImage];
    [downloadResources resourcesFilePath:@"" folderName:modelFolderName resourcesType:fileModel];
    NSString *cachespath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *targetPath1 = [cachespath stringByAppendingFormat:@"%@%@%@",@"/",imageFolderName,@"/vrar_model.jpeg"];
    NSString *targetPath2 = [cachespath stringByAppendingFormat:@"%@%@%@",@"/",modelFolderName,@"/vrar.obj"];
    NSString *targetPath3 = [cachespath stringByAppendingFormat:@"%@%@%@",@"/",modelFolderName,@"/vrar.mtl"];
    NSString *sourcePath1 = [[NSBundle mainBundle]pathForResource:@"vrar_model" ofType:@"jpeg"];
    NSString *sourcePath2 = [[NSBundle mainBundle]pathForResource:@"vrar" ofType:@"obj"];
    NSString *sourcePath3 = [[NSBundle mainBundle]pathForResource:@"vrar" ofType:@"mtl"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager copyItemAtPath:sourcePath1 toPath:targetPath1 error:nil];
    [manager copyItemAtPath:sourcePath2 toPath:targetPath2 error:nil];
    [manager copyItemAtPath:sourcePath3 toPath:targetPath3 error:nil];
}
 
+(CGImageRef) convertCIImageToCGImage:(CIImage *) inputImage {
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef ref = [context createCGImage:inputImage fromRect:inputImage.extent];
    return ref;
}

@end
