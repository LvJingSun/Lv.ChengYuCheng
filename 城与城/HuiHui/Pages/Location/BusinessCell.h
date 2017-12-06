//
//  BusinessCell.h
//  baozhifu
//
//  Created by mac on 13-8-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"

@protocol MapDelegate <NSObject>

- (void)openBaiduMap:(NSDictionary *)item;

@end

@interface BusinessCell : UITableViewCell {
    
}

//@property (weak, nonatomic) LocationViewController *merchantView;

@property (strong, nonatomic) NSMutableDictionary *item;

@property (weak, nonatomic) ImageCache *imageCache;

@property (strong, nonatomic) UIWebView *m_webView;

@property (nonatomic, assign) id <MapDelegate> delegate;

// 记录是收藏还是取消收藏
@property (nonatomic, strong) NSString       *m_typeString;


- (void)setValue;

// 判断网络不好
- (BOOL)isConnectionAvailable;

@end

@interface PartyCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *m_imagV;

@property (weak, nonatomic) IBOutlet UILabel *m_productName;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_orignLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_lineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_statusImagV;

@property (weak, nonatomic) IBOutlet UILabel *m_ageLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_sexLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_validateTimeLabel;

@property (weak, nonatomic) ImageCache *imageCache;

- (void)setImageView:(NSString *)imagePath;

@end