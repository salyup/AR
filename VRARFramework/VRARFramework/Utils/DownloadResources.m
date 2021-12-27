//
//  DownloadResources.m
//  DownloadResources
//
//  Created by 平林艳 on 2021/11/23.
//  Copyright © 2021 Maxim Makhun. All rights reserved.
//

#import "DownloadResources.h"
#import "Constants.h"
#import "SSZipArchive.h"

@interface DownloadResources ()
@property (nonatomic,strong) NSString *cachesPath;

@end

@implementation DownloadResources
- (instancetype)init {
    self = [super init];

    if (self) {
        self.cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    }

    return self;
}

- (NSString *)downloadFile:(NSArray *) imageUrlArray modelUrl:(NSArray *) modelUrlArray movieUrl:(NSArray *) movieUrlArray{
    NSFileManager *manager = [NSFileManager defaultManager];
    // 下载识别图
    for(id url in imageUrlArray){
        UIImage *image = [self loadLocalImage:url folderName:imageFolderName];
        NSData *imageData = UIImagePNGRepresentation(image);
        if (imageData == nil) {
            //如果存在文件不需要再次下载，如果不存在则下载，若下载失败返回failed
            if(![[self connectionURL:url folderName:imageFolderName resourcesType:fileImage] isEqualToString:@"success"]){
                return @"Download failed";
            }
        }
    }
    // 下载模型
    for(id url in modelUrlArray){
        NSString *tmpName = [self resourcesFileName: url resourcesType:fileModel];
        NSString *path  = [self.cachesPath stringByAppendingFormat:@"%@%@%@%@",@"/",modelFolderName,@"/",tmpName];
        NSString *unzippath  = [self.cachesPath stringByAppendingFormat:@"%@%@%@",@"/",modelFolderName,@"/"];
        if(![manager fileExistsAtPath:path]){
            [self connectionURL:url folderName:modelFolderName resourcesType:fileModel];
        }
        NSError *error;
        if (![SSZipArchive unzipFileAtPath:path toDestination:unzippath overwrite:YES password:nil error:&error]) {
           NSLog(@"[%s]解压失败：%@", __FUNCTION__,error);
        }
    }
//    for(id url in modelUrlArray){
//        NSString *tmpName = [self resourcesFileName: url resourcesType:fileModel];
//        NSString *path  = [self.cachesPath stringByAppendingFormat:@"%@%@%@%@",@"/",modelFolderName,@"/",tmpName];
//        if(![manager fileExistsAtPath:path]){
//            [self connectionURL:url folderName:modelFolderName resourcesType:fileModel];
//        }
//    }
    return @"Download complete";
}

//获取图片data数据
- (FileData *)getImgsData:(NSString *)resourcesUrl folderName: (NSString *) fName uImg: (UIImage *)image {
    FileData *data = [FileData alloc];
    NSString *tmpName = [self resourcesFileName: resourcesUrl resourcesType:fileImage];
    NSArray *array = [tmpName componentsSeparatedByString:@"."];
    data.imgName = array[0];
    data.imgData = UIImagePNGRepresentation(image);
    return data;
}

//下载文件
- (NSString *)connectionURL:(NSString *) resourcesUrl folderName: (NSString *) fName resourcesType: (NSString *)type {
    __block NSString *re = @"success";
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
    NSURL *url = [NSURL URLWithString:[resourcesUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request setTimeoutInterval:60];
//    [request setAllHTTPHeaderFields:nil];
//    [request setHTTPBody:(NSData *)[@"user_name=admin&user_password=admin" dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            [data writeToFile:[self resourcesFilePath:resourcesUrl folderName:fName resourcesType:type] atomically:YES];
        }
        if (error != nil){
            re = [@"fail__" stringByAppendingFormat:@"%@",error.domain];
        }
        dispatch_semaphore_signal(semaphore);   //发送信号
    }];
    [task resume];
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);  //等待
    NSLog(@"resources: %@ download %@",resourcesUrl,re);
    return re;
}


//获取资源路径
- (NSString *)resourcesFilePath:(NSString *)resourcesUrl folderName: (NSString *) fName resourcesType: (NSString *)type {
    NSString *downloadImagesPath = [self.cachesPath stringByAppendingPathComponent:fName];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:downloadImagesPath]) {
        [fileManager createDirectoryAtPath:downloadImagesPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * resourcesName = [self resourcesFileName: resourcesUrl resourcesType:type];
    NSString * resourcesFilePath = [downloadImagesPath stringByAppendingPathComponent:resourcesName];
    return resourcesFilePath;
}

//根据下载地址设置下载文件名
- (NSString *)resourcesFileName:(NSString *)resourcesUrl resourcesType: (NSString *)type{
    NSArray *array = [resourcesUrl componentsSeparatedByString:@"/"];
    NSString * resourcesName = array[array.count-1];
    if([type isEqualToString: fileImage]){
        if (![resourcesName hasSuffix:@".jpeg"]) {
            resourcesName = [array[array.count-1] stringByAppendingFormat:@".jpeg"];
        }
    }
//    }else if([type isEqualToString:fileModel]){
//        if (![resourcesName hasSuffix:@".obj"]) {
//            resourcesName = [array[array.count-1] stringByAppendingFormat:@".obj"];
//        }
//    }
    return resourcesName;
}

// 获取图片资源
- (UIImage *)loadLocalImage:(NSString *)resourcesUrl folderName: (NSString *) fName {
    NSString * filePath = [self resourcesFilePath:resourcesUrl folderName:fName resourcesType:fileImage] ;
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (image != nil) {
      return image;
    }
    return nil;
}

@end
