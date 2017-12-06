//
//  MyCardCell.h
//  HuiHui
//
//  Created by 冯海强 on 14-6-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"
#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"


@interface MyCardCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UIImageView *CardImage;

@property (nonatomic, weak) IBOutlet UILabel *Businessname;

@property (nonatomic, weak) IBOutlet UILabel *Cardname;

@property (weak, nonatomic) ImageCache *imageCache;

- (void)setImageView:(NSString *)imagePath;

@end

@interface MyCardCell1 : UITableViewCell

@property (weak, nonatomic) ImageCache *imageCache;

@property (nonatomic, weak) IBOutlet UIImageView *BusinessImage;

@property (nonatomic, weak) IBOutlet UILabel *Businessname;

@property (nonatomic, weak) IBOutlet UILabel *Cardname;


- (void)setImageView:(NSString *)imagePath;

@end


@interface AccountProductCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *m_name;

@property (nonatomic, weak) IBOutlet UILabel *m_time;

@end