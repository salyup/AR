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
        if (imageData == nil) {
           //use default
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *docpath1 = [cachesPath stringByAppendingFormat:@"%@%@%@",@"/",imageFolderName,@"/js.jpeg"];
            UIImage *uiimg1 = [UIImage imageWithContentsOfFile:docpath1];
            CGImageRef ref1 = uiimg1.CGImage;
            ARReferenceImage *arimg1 = [[ARReferenceImage alloc] initWithCGImage:ref1 orientation:kCGImagePropertyOrientationUp physicalWidth:0.2f];
            arimg1.name = @"js";
            [array addObject:arimg1];
        }else{
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
 
+(CGImageRef) convertCIImageToCGImage:(CIImage *) inputImage {
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef ref = [context createCGImage:inputImage fromRect:inputImage.extent];
    return ref;
}

@end
