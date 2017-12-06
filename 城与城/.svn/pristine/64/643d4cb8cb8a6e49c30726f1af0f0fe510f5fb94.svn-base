//
//  MyserviceTableViewCell.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MyserviceTableViewCell.h"

@implementation MyserviceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)SetServicePhoto:(NSString *)imagePath
{
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.PhotoImage.image = reSizeImage;
        self.PhotoImage.layer.masksToBounds = YES; //没这句话它圆不起来
        self.PhotoImage.layer.cornerRadius = 8.0; //设置图片圆角的尺度
        self.PhotoImage.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    
    UIImageView * imgv = [[UIImageView alloc]init];
    
    [imgv setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             
                             self.PhotoImage.image = image;
                             self.PhotoImage.contentMode = UIViewContentModeScaleAspectFill;
                             self.PhotoImage.layer.masksToBounds = YES; //没这句话它圆不起来
                             self.PhotoImage.layer.cornerRadius = 8.0; //设置图片圆角的尺度
                             [self.imageCache addImage:image andUrl:imagePath];
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             self.PhotoImage.image = [UIImage imageNamed:@"invite_reg_no_photo.png"];
                             self.PhotoImage.layer.masksToBounds = YES; //没这句话它圆不起来
                             self.PhotoImage.layer.cornerRadius = 8.0; //设置图片圆角的尺度
                             
                         }];
    
}

@end
