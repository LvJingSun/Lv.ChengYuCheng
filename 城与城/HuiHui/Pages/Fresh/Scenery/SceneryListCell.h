//
//  SceneryListCell.h
//  HuiHui
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

@interface SceneryListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_showImagV;

@property (weak, nonatomic) IBOutlet UILabel *m_title;

@property (weak, nonatomic) IBOutlet UILabel *m_subTitle;

@property (weak, nonatomic) IBOutlet UILabel *m_themName;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_orignPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_distance;

@property (weak, nonatomic) IBOutlet UILabel *m_fanli;

@property (weak, nonatomic) ImageCache *imageCache;


- (void)setImageView:(NSString *)path;

@end


@interface SceneryChooseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UIButton *m_btn;

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;

@end