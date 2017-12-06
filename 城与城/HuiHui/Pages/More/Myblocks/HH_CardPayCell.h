//
//  HH_CardPayCell.h
//  HuiHui
//
//  Created by mac on 15-6-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"
#import "HCSStarRatingView.h"


@interface HH_CardPayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@end


@interface HH_CardNoPayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_payType;

@property (weak, nonatomic) IBOutlet UILabel *m_balance;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;



@end


@interface HH_MactMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_menuImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_mactLogo;

@property (weak, nonatomic) IBOutlet UILabel *m_mactName;

@property (weak, nonatomic) ImageCache *imageCache;

- (void)setImagePath:(NSString *)imagePath;

- (void)setMactLogImagePath:(NSString *)imagePath;


@end

@interface HH_MactMenuCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_menuImgV;

@property (weak, nonatomic) IBOutlet UILabel *MerchantShopName;
@property (weak, nonatomic) IBOutlet UILabel *QsPrice;//起送价
@property (weak, nonatomic) IBOutlet UILabel *QsPriceLabel;//起送价
@property (weak, nonatomic) IBOutlet UILabel *PsMinutesDistancePsPrice;//配送时间 ，Distance距离，配送费PsPrice
@property (weak, nonatomic) IBOutlet UILabel *LastMonthSales;//月售
@property (weak, nonatomic) IBOutlet UILabel *FirstBuyDesc;
@property (weak, nonatomic) IBOutlet UILabel *Jian;
@property (weak, nonatomic) IBOutlet UILabel *MLZDesc;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ScoreV;
@property (weak, nonatomic) IBOutlet UIView *IsZCFirstBuy;
@property (weak, nonatomic) IBOutlet UIView *IsZCHowMuchLess;
@property (weak, nonatomic) IBOutlet UIView *IsZCMLZ;
@property (weak, nonatomic) IBOutlet UIImageView *lingeView;


@property (weak, nonatomic) ImageCache *imageCache;

- (void)setMactLogImagePath:(NSString *)imagePath;
- (void)setSeroes:(NSString *)Score;

@end