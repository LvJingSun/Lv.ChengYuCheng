//
//  ProductDetailCell.h
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailCell : UITableViewCell

// 随时
@property (weak, nonatomic) IBOutlet UIImageView *m_randomImgV;
// 过期
@property (weak, nonatomic) IBOutlet UIImageView *m_ExpiredImagV;
// 预约
@property (weak, nonatomic) IBOutlet UIImageView *m_ReservationImgV;
// 已售
@property (weak, nonatomic) IBOutlet UILabel *m_saled;
// 还剩
@property (weak, nonatomic) IBOutlet UILabel *m_remain;
// 剩余时间
@property (weak, nonatomic) IBOutlet UILabel *m_time;

// 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_anyTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_expiredLabek;

@property (weak, nonatomic) IBOutlet UILabel *m_reserLabel;

@end


@interface StartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_img1V;

@property (weak, nonatomic) IBOutlet UIImageView *m_img2V;

@property (weak, nonatomic) IBOutlet UIImageView *m_img3V;

@property (weak, nonatomic) IBOutlet UIImageView *m_img4V;

@property (weak, nonatomic) IBOutlet UIImageView *m_img5V;

@property (weak, nonatomic) IBOutlet UIImageView *m_arrowImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_countLabel;


- (void)setValue:(NSString *)aString withCount:(NSString *)aCount;

@end

@interface ShopInforCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_moreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_arrowImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_shopName;

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@property (weak, nonatomic) IBOutlet UIButton *m_moreBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_mapBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_phoneBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;



@end

@interface IntroductionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_detailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_infoImgV;

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;



@end

@interface OtherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_clickedBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_otherName;

@end


@interface OtherOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_productName;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;


@end
