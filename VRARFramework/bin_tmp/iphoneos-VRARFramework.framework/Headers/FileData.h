//
//  FileData.h
//  FileData
//
//  Created by 平林艳 on 2021/12/2.
//  Copyright © 2021 Maxim Makhun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileData : NSObject
@property (nonatomic) NSString *imgName;
@property (nonatomic) NSData *imgData;

@end

NS_ASSUME_NONNULL_END
