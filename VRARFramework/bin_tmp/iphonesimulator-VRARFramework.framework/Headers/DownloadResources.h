//
//  DownloadResources.h
//  DownloadResources
//
//  Created by 平林艳 on 2021/11/23.
//  Copyright © 2021 Maxim Makhun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FileData.h"

NS_ASSUME_NONNULL_BEGIN

@interface DownloadResources : NSObject

- (NSString *)downloadFile:(NSArray *) imageUrlArray modelUrl:(NSArray *) modelUrlArray movieUrl:(NSArray *) movieUrlArray;
- (FileData *)getImgsData:(NSString *)resourcesUrl folderName: (NSString *) fName uImg: (UIImage *)image;
- (UIImage *)loadLocalImage:(NSString *)resourcesUrl folderName: (NSString *) fName;
- (NSString *)resourcesFilePath:(NSString *)resourcesUrl folderName: (NSString *) fName resourcesType: (NSString *)type;
@end

NS_ASSUME_NONNULL_END
