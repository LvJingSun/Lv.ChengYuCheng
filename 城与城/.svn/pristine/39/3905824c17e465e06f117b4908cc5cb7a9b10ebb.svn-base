//
//  HHCouponCell.h
//  HuiHui
//
//  Created by mac on 15-2-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

@interface HHCouponView : UIView

@property (weak, nonatomic) IBOutlet UILabel *m_mctName;

@property (weak, nonatomic) IBOutlet UILabel *m_sPrice;

@property (weak, nonatomic) IBOutlet UIImageView *m_imagV;

@property (weak, nonatomic) IBOutlet UILabel *m_subTitle;

@property (weak, nonatomic) IBOutlet UIButton *m_btn;

@end

@interface HHCouponCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HHCouponView *m_leftView;

@property (weak, nonatomic) IBOutlet HHCouponView *m_rightView;

@property (weak, nonatomic) ImageCache *imageCache;


- (void)setImageLeft:(NSString *)imagePath;
- (void)setImageRight:(NSString *)imagePath;

@end


@interface HHQuanquanListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_mctName;

@property (weak, nonatomic) IBOutlet UIImageView *m_imagV;

@property (weak, nonatomic) IBOutlet UILabel *m_title;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UIView *m_view;

@property (weak, nonatomic) ImageCache *imageCache;

@property (weak, nonatomic) IBOutlet UIButton *m_btn;

- (void)setImagePath:(NSString *)imagePath;


@end


@interface QuanquanMoreCell : UITableViewCell



@end
