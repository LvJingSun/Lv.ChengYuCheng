//
//  CoverUtility.h
//  HuiHui
//
//  Created by mac on 15-2-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>



@class  CoverUtility;

@interface  CoverUtility : NSObject
{
    
    NSString *coverImageURL;
}

+ ( CoverUtility *)sharedCoverUtility;

// 判断本地是否存在引导页图片，存在则加载并返回UIImage，否则返回nil
- (UIImage *)getLocalCoverImage;
// 获得引导页图片显示时间
- (NSUInteger)getCoverImageShowTime;

- (void)onImageLoaded:(UIImage *)image;


@property (nonatomic, copy) NSString        *coverImageURL;

@property (nonatomic, strong) UIImageView   *m_imageView;

@end
