//
//  SaleProductListCell.h
//  HuiHui
//
//  Created by mac on 14-2-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

@interface SaleProductListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_orignPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_Priceline;

@property (weak, nonatomic) IBOutlet UILabel *m_hourLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_minusLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_secondLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_lineImageV;

@property (weak, nonatomic) IBOutlet UIButton *m_qianggouBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_label;

@property (weak, nonatomic) IBOutlet UIImageView *m_statusImagV;

@property (weak, nonatomic) IBOutlet UILabel *m_infoLabel;

@property (weak, nonatomic) IBOutlet UIView *m_timeView;

@property (weak, nonatomic) IBOutlet UILabel *m_endLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_countLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_tokenLabel;

@property (weak, nonatomic) ImageCache *imageCache;


- (void)setImageView:(NSString *)imagePath;


@end


@interface SaleDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_detailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;



@end
