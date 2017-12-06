//
//  OrderCell.m
//  HuiHui
//
//  Created by mac on 13-11-26.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "OrderCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation OrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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
    __weak OrderCell *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         self.m_imageView.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
                                         [weakCell setNeedsLayout];
                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}

@end


@implementation OrderPayedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setImageString:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imgCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imageView.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak OrderPayedCell *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
                                         [weakCell setNeedsLayout];
                                         [self.imgCache addImage:self.m_imageView.image andUrl:imagePath];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}


@end



@implementation dp_OrderPayedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
