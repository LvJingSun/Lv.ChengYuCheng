//
//  FavoriteCell.m
//  HuiHui
//
//  Created by mac on 14-9-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FavoriteCell.h"
#import "UIImageView+AFNetworking.h"
#import "CommonUtil.h"

@implementation FavoriteCell

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
    self.m_imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.m_imageView.layer.borderWidth = 1.0;
    
    __weak FavoriteCell *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                    
                                     self.m_imageView.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
                                     self.m_imageView.contentMode = UIViewContentModeScaleToFill;
                                     [weakCell setNeedsLayout];
                                     [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];

                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
    
}


@end
