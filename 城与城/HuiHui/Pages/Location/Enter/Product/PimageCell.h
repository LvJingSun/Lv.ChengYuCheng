//
//  PimageCell.h
//  baozhifu
//
//  Created by 冯海强 on 14-1-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"
#import "PimageViewController.h"

@interface PimageCell : UITableViewCell


@property (strong, nonatomic) PimageViewController *PimageViewController;

@property (weak, nonatomic) IBOutlet UIImageView *P_Cellimageicon;

@property (weak, nonatomic) IBOutlet UIImageView *P_Cellimage;

@property (weak, nonatomic) IBOutlet UILabel *P_Celltext;

@property (weak, nonatomic) IBOutlet UILabel *P_Celldetailtext;

@property (weak, nonatomic) NSString *Cellimagepath;

@property (weak, nonatomic) ImageCache *imageCache;



- (void)setImageCell;

@end
