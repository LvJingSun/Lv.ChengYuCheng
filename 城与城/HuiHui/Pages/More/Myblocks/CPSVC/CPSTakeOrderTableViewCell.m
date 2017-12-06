//
//  CPSTakeOrderTableViewCell.m
//  HuiHui
//
//  Created by fenghq on 15/9/23.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CPSTakeOrderTableViewCell.h"
#import "LSPaoMaView.h"
#import "UIImageView+AFNetworking.h"

@implementation CPSTakeOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
@implementation CPSTakeOrderTableViewCell1

- (void)awakeFromNib {
    self.headImageV.layer.masksToBounds = YES;
    self.headImageV.layer.cornerRadius = self.headImageV.frame.size.width/2; //圆角（圆形)
    //防止掉帧（列表不卡了）
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setMactLogImagePath:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.headImageV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak CPSTakeOrderTableViewCell1 *weakCell = self;
    [self.headImageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                     placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                  
                                  self.headImageV.image = image;
                                  self.headImageV.contentMode = UIViewContentModeScaleToFill;
                                  [weakCell setNeedsLayout];
                                  [self.imageCache addImage:self.headImageV.image andUrl:imagePath];
                                  
                              }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                  
                              }];
    
}

@end
@implementation CPSTakeOrderTableViewCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setMactLogImagePath:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.Logo.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak CPSTakeOrderTableViewCell2 *weakCell = self;
    [self.Logo setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                           placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                        
                                        self.Logo.image = image;
                                        self.Logo.contentMode = UIViewContentModeScaleToFill;
                                        [weakCell setNeedsLayout];
                                        [self.imageCache addImage:self.Logo.image andUrl:imagePath];
                                        
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                        
                                    }];
    
}

@end
@implementation CPSTakeOrderTableViewCell3

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
@implementation CPSTakeOrderTableViewCell4

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end