//
//  UrlService.h
//  ARPlayer
//
//  Created by 徐长帆 on 2021/10/25.
//  Copyright © 2021 Maxim Makhun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileData.h"

NS_ASSUME_NONNULL_BEGIN

@interface UrlService : NSObject
+ (NSArray<NSURL *> *) list:(NSArray<NSString *> *) ufileids;
+ (NSURL *) single:(NSString *) ufileid;
+ (void) loadDynamicImageReference:(NSArray<NSString *> * __nullable) urls withConfig:(ARWorldTrackingConfiguration *) config ;
@end

NS_ASSUME_NONNULL_END
