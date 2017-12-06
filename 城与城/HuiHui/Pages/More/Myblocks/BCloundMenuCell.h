//
//  BCloundMenuTableViewCell.h
//  HuiHui
//
//  Created by 冯海强 on 15-5-21.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

@interface BCloundMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_labeltext;

@property (weak, nonatomic) IBOutlet UILabel *m_amoutLabel;

@end

@interface BCloundMenuCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *m_labelname;
@property (weak, nonatomic) IBOutlet UILabel *m_labelpice;

@property (weak, nonatomic) IBOutlet UIButton *m_Btnjian;
@property (weak, nonatomic) IBOutlet UIButton *m_Btnjia;
@property (weak, nonatomic) IBOutlet UIButton *m_Btnnum;
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_orignPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_line;


@property (weak, nonatomic) ImageCache *imageCache;

- (void)setImagePath:(NSString *)imagePath;

@end


@interface BCloundMenuTaocanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_labelname;
@property (weak, nonatomic) IBOutlet UILabel *m_labelpice;

@property (weak, nonatomic) IBOutlet UIButton *m_Btnjian;
@property (weak, nonatomic) IBOutlet UIButton *m_Btnjia;
@property (weak, nonatomic) IBOutlet UIButton *m_Btnnum;
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_usedCount;
@property (weak, nonatomic) ImageCache *imageCache;
@property (weak, nonatomic) IBOutlet UILabel *m_time;

- (void)setImagePath:(NSString *)imagePath;

@end


@interface BCloundMenuOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_menuName;

@property (weak, nonatomic) IBOutlet UILabel *m_menuPrice;

@property (weak, nonatomic) IBOutlet UIButton *m_Btnjian1;

@property (weak, nonatomic) IBOutlet UIButton *m_Btnjia1;

@property (weak, nonatomic) IBOutlet UIButton *m_Btnnum;

@property (weak, nonatomic) IBOutlet UILabel *m_customName;


@end

