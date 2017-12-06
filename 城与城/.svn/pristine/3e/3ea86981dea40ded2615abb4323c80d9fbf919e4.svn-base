//
//  Ctrip_hotelOrderTableViewCell.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "Ctrip_hotelOrderTableViewCell.h"

@implementation Ctrip_hotelOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCtrip_hotelImage:(NSString *)imagepath
{
    UIImage *reSizeImage = [imagechage getImage:imagepath];
    if (reSizeImage != nil)
    {
        [self.PhotoIMG setImage:reSizeImage];
    }
    else{
        [self.PhotoIMG setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imagepath]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [self.PhotoIMG setImage:image];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            [self.PhotoIMG setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }];
        
    }
    
}

@end
