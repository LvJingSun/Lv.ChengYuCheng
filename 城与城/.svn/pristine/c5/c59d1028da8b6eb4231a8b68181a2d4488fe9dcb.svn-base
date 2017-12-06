//
//  CtriphotellistCell.m
//  HuiHui
//
//  Created by 冯海强 on 14-9-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CtriphotellistCell.h"

@implementation CtriphotellistCell

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


-(void)setCtrip_hotelImage:(NSString *)imagepath
{
    UIImage *reSizeImage = [imagechage getImage:imagepath];
    
    if (reSizeImage != nil)
    {
        [self.hotel_imageview setImage:reSizeImage];
        
    }
    else{
        
        [self.hotel_imageview setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imagepath]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            [self.hotel_imageview setImage:image];
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
            [self.hotel_imageview setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }];
        
    }
    
}


@end
