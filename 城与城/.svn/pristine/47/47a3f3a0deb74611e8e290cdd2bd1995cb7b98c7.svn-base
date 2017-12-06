//
//  NewCommentwCell.m
//  HuiHui
//
//  Created by mac on 14-9-1.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "NewCommentwCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation NewCommentwCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setImageView:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imageView.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak NewCommentwCell *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                            placeholderImage:[UIImage imageNamed:@"moren.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
                                         [weakCell setNeedsLayout];
                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}


- (void)setImageViewBigPath:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_contentImagV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak NewCommentwCell *weakCell = self;
    [self.m_contentImagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                               placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                            self.m_contentImagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                            //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
                                            [weakCell setNeedsLayout];
                                            [self.imageCache addImage:self.m_contentImagV.image andUrl:imagePath];
                                        }
                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                            
                                        }];
    
}


@end
