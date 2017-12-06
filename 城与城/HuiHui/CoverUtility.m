//
//  CoverUtility.m
//  HuiHui
//
//  Created by mac on 15-2-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CoverUtility.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "Configuration.h"

@interface CoverUtility (private)

// 读取本地图片路径
- (NSString *)getLocalImagePath;
// 保存图片到本地默认路径
- (BOOL)saveImage:(UIImage *)image;
// 加载网络图片
- (void)loadImageFromURL:(NSString *)imageURL;
// 图片加载完成后的回调
- (void)onImageLoaded:(UIImage *)image param:(id)param;

@end

static CoverUtility *coverUtility;

@implementation CoverUtility

@synthesize m_imageView;

+ (CoverUtility *)sharedCoverUtility{
    @synchronized(self) {
        if (coverUtility == nil) {
            coverUtility = [[self alloc] init];
        }
        return coverUtility;
    }
}

- (id)init
{
    self = [super init];
    if ( self ) {
        // 请求网络
//        [self requestSubmit];
        
//        [self loadImageFromURL:self.coverImageURL];

    }
    return self;
}

// 从本地图片加载图片到UIImage
- (UIImage *)getLocalCoverImage{
    
    UIImage *coverImage = nil;
    NSString *filePath = [self getLocalImagePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ( [fileManager fileExistsAtPath:filePath] ) {
        
        coverImage = [UIImage imageWithContentsOfFile:[self getLocalImagePath]];
        
    }else{
        
        coverImage = [UIImage imageNamed:@"huihui.png"];

    }
    
    return coverImage;
}

#pragma mark - 本地相关
// 从NSUserDefaults读取引导页图片显示时间
- (NSUInteger)getCoverImageShowTime{
    NSUInteger showTime = kDefaultShowTime;
    NSInteger time = [[[NSUserDefaults standardUserDefaults]objectForKey:kCoverImageShowTimeKey]integerValue];
    if ( time > 0 ){
        showTime = time;
    }
    return showTime;
}

// 获取图片本地路径
- (NSString *)getLocalImagePath{
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:kCoverImageName];
}

// 保存图片到本地
- (BOOL)saveImage:(UIImage *)image{
    BOOL success = YES;
    NSString *filePath = [self getLocalImagePath];
    NSError *error = nil;
    [UIImagePNGRepresentation(image) writeToFile:filePath options:NSDataWritingAtomic error:&error];
    if ( error != nil ) {
        success = NO;
    }
    return success;
}

#pragma mark - Properties
@synthesize coverImageURL;

@end
