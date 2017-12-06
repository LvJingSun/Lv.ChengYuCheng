//
//  MyserviceTableViewCell.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"

@interface MyserviceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *PhotoImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) ImageCache *imageCache;


-(void)SetServicePhoto:(NSString *)imagePath;

@end
