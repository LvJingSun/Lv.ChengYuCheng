//
//  CardMenuOrderCell.h
//  HuiHui
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"


@interface CardMenuOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_menuName;

@property (weak, nonatomic) IBOutlet UILabel *m_menuPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_menuCount;

@property (weak, nonatomic) ImageCache *imageCache;


- (void)setImageView:(NSString *)imagePath;

@end

@interface CardMenuOrderCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *MenuImageS;

@property (weak, nonatomic) IBOutlet UILabel *MenuName;

@property (weak, nonatomic) IBOutlet UILabel *MenuAmount;

@property (weak, nonatomic) IBOutlet UILabel *MenuPrice;

@property (weak, nonatomic) ImageCache *imageCache;


- (void)setImageView:(NSString *)imagePath;

@end