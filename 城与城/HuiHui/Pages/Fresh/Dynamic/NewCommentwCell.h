//
//  NewCommentwCell.h
//  HuiHui
//
//  Created by mac on 14-9-1.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"


@interface NewCommentwCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_contentImagV;

@property (weak, nonatomic) IBOutlet UILabel *m_commentLabel;

@property (weak, nonatomic) ImageCache *imageCache;

- (void)setImageView:(NSString *)imagePath;

- (void)setImageViewBigPath:(NSString *)imagePath;

@end
