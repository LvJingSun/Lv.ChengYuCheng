//
//  OrderCell.h
//  HuiHui
//
//  Created by mac on 13-11-26.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_productName;

@property (weak, nonatomic) IBOutlet UILabel *m_keyTime;

@property (weak, nonatomic) IBOutlet UILabel *m_count;

@property (weak, nonatomic) IBOutlet UILabel *m_unitPrice;

@property (weak, nonatomic) IBOutlet UIButton *m_cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_payBtn;

@property (weak, nonatomic) ImageCache *imageCache;



- (void)setImageView:(NSString *)imagePath;



@end


@interface OrderPayedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UIImageView *m_statusImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_productName;

@property (weak, nonatomic) IBOutlet UILabel *m_keyTime;

@property (weak, nonatomic) IBOutlet UILabel *m_countLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeInfo;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;

@property (weak, nonatomic) ImageCache *imgCache;



- (void)setImageString:(NSString *)imagePath;


@end


@interface dp_OrderPayedCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *dp_order_id;

@property (weak, nonatomic) IBOutlet UILabel *dp_timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *dp_priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *dp_numLabel;




@end
