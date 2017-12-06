//
//  SceneryDetailCell.h
//  HuiHui
//
//  Created by mac on 15-1-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景点详情的自定义cell

#import <UIKit/UIKit.h>

#import "SceneryStarView.h"

#import "ImageCache.h"

@interface SceneryDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet SceneryStarView *m_starView;


- (void)setStarViewWithStar:(float)aValue;

@end



@interface SceneryPictureCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_leftImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_middleImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_rightImgV;

@property (weak, nonatomic) IBOutlet UIButton *m_leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_middleBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_rightBtn;

@property (weak, nonatomic) ImageCache *imageCache;


// 赋值图片
- (void)setImageLeft:(NSString *)imagePath;
- (void)setImageMiddle:(NSString *)imagePath;
- (void)setImageRight:(NSString *)imagePath;


@end


@interface SceneryMapCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UIImageView *m_imagV;

@end

@interface SceneryNoticeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_notice;

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end


