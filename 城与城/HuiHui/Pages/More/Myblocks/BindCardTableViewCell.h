//
//  BindCardTableViewCell.h
//  HuiHui
//
//  Created by 冯海强 on 15-3-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"
#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"
@interface BindCardTableViewCell : UITableViewCell


@end

@interface BindCardTableViewCell1 : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *upview;
@property (nonatomic, weak) IBOutlet UIImageView *downview;

@end

@interface BindCardTableViewCell2 : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *Carddescribe;

@end

@interface BindCardTableViewCell3 : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *Businessphoto;

@property (weak, nonatomic) ImageCache *imageCache;

- (void)setImageView:(NSString *)imagePath;


@end

@interface BindCardTableViewCell4 : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *ShopName;
@property (nonatomic, weak) IBOutlet UILabel *disrictName;



@end