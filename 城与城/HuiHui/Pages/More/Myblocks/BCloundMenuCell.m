//
//  BCloundMenuTableViewCell.m
//  HuiHui
//
//  Created by 冯海强 on 15-5-21.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BCloundMenuCell.h"

#import "UIImageView+AFNetworking.h"


@implementation BCloundMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation BCloundMenuCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self.m_Btnjia.layer setBorderWidth:1.0]; //边框宽度
    [self.m_Btnjian.layer setBorderWidth:1.0]; //边框宽度
    [self.m_Btnnum.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){190/255.0, 204/255.0, 205/255.0, 1 });
    [self.m_Btnjia.layer setBorderColor:colorref];//边框颜色
    [self.m_Btnjian.layer setBorderColor:colorref];//边框颜色
    [self.m_Btnnum.layer setBorderColor:colorref];//边框颜色

}

- (void)setImagePath:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imageView.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak BCloundMenuCell1 *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                          placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                       
                                       self.m_imageView.image = image; //[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                       //                                     self.m_numImgV.contentMode = UIViewContentModeScaleToFill;
                                       [weakCell setNeedsLayout];
                                       
                                       [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                       
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                       
                                   }];
    
}



@end


@implementation BCloundMenuTaocanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self.m_Btnjia.layer setBorderWidth:1.0]; //边框宽度
    [self.m_Btnjian.layer setBorderWidth:1.0]; //边框宽度
    [self.m_Btnnum.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){190/255.0, 204/255.0, 205/255.0, 1 });
    [self.m_Btnjia.layer setBorderColor:colorref];//边框颜色
    [self.m_Btnjian.layer setBorderColor:colorref];//边框颜色
    [self.m_Btnnum.layer setBorderColor:colorref];//边框颜色
    
}


- (void)setImagePath:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imageView.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak BCloundMenuTaocanCell *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         
                                         self.m_imageView.image = image; //[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         //                                     self.m_numImgV.contentMode = UIViewContentModeScaleToFill;
                                         [weakCell setNeedsLayout];
                                         
                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                         
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}


@end


@implementation BCloundMenuOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self.m_Btnjia1.layer setBorderWidth:1.0]; //边框宽度
    [self.m_Btnjian1.layer setBorderWidth:1.0]; //边框宽度
    [self.m_Btnnum.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){190/255.0, 204/255.0, 205/255.0, 1 });
    [self.m_Btnjia1.layer setBorderColor:colorref];//边框颜色
    [self.m_Btnjian1.layer setBorderColor:colorref];//边框颜色
    [self.m_Btnnum.layer setBorderColor:colorref];//边框颜色
    
}


@end


