//
//  HHCouponCell.m
//  HuiHui
//
//  Created by mac on 15-2-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HHCouponCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation HHCouponView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }  
    return self;
}

@end


@implementation HHCouponCell

- (void)awakeFromNib {
    // Initialization code
  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageLeft:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_leftView.m_imagV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak HHCouponCell *weakCell = self;
    [self.m_leftView.m_imagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                           placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                        
                                        self.m_leftView.m_imagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(90, 68)];
                                        self.m_leftView.m_imagV.contentMode = UIViewContentModeScaleToFill;
                                        [weakCell setNeedsLayout];
                                        [self.imageCache addImage:self.m_leftView.m_imagV.image andUrl:imagePath];
                                        
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                        
                                    }];
    
}

- (void)setImageRight:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_rightView.m_imagV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak HHCouponCell *weakCell = self;
    [self.m_rightView.m_imagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                             placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                          
                                          self.m_rightView.m_imagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(90, 68)];
                                          self.m_rightView.m_imagV.contentMode = UIViewContentModeScaleToFill;
                                          [weakCell setNeedsLayout];
                                          [self.imageCache addImage:self.m_rightView.m_imagV.image andUrl:imagePath];
                                          
                                      }
                                      failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                          
                                      }];
}


@end

@implementation HHQuanquanListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setImagePath:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imagV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak HHQuanquanListCell *weakCell = self;
    [self.m_imagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                                   placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                
                                                self.m_imagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                self.m_imagV.contentMode = UIViewContentModeScaleToFill;
                                                [weakCell setNeedsLayout];
                                                
                                                [self.imageCache addImage:self.m_imagV.image andUrl:imagePath];
                                                
                                            }
                                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                
                                            }];
    
}

@end

@implementation QuanquanMoreCell

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
