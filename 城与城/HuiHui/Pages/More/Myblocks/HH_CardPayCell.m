//
//  HH_CardPayCell.m
//  HuiHui
//
//  Created by mac on 15-6-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_CardPayCell.h"

#import "UIImageView+AFNetworking.h"

@implementation HH_CardPayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation HH_CardNoPayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation HH_MactMenuCell

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
        self.m_menuImgV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak HH_MactMenuCell *weakCell = self;
    [self.m_menuImgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                      
                                      self.m_menuImgV.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
                                      self.m_menuImgV.contentMode = UIViewContentModeScaleToFill;
                                      [weakCell setNeedsLayout];
                                      [self.imageCache addImage:self.m_menuImgV.image andUrl:imagePath];
                                      
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];
    
}

- (void)setMactLogImagePath:(NSString *)imagePath{

    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_menuImgV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak HH_MactMenuCell *weakCell = self;
    [self.m_mactLogo setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                           placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                        
                                        self.m_mactLogo.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
                                        self.m_mactLogo.contentMode = UIViewContentModeScaleToFill;
                                        [weakCell setNeedsLayout];
                                        [self.imageCache addImage:self.m_mactLogo.image andUrl:imagePath];
                                        
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                        
                                    }];
    
}




@end

@implementation HH_MactMenuCell1

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
        self.m_menuImgV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak HH_MactMenuCell1 *weakCell = self;
    [self.m_menuImgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                           placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                        
                                        self.m_menuImgV.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
                                        self.m_menuImgV.contentMode = UIViewContentModeScaleToFill;
                                        [weakCell setNeedsLayout];
                                        [self.imageCache addImage:self.m_menuImgV.image andUrl:imagePath];
                                        
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                        
                                    }];
    
}

- (void)setSeroes:(NSString *)Score{

//    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 0, self.ScoreV.frame.size.width, self.ScoreV.frame.size.height)];
    self.ScoreV.maximumValue = 5;
    self.ScoreV.minimumValue = 0;
    self.ScoreV.value = [Score floatValue];
    self.ScoreV.userInteractionEnabled = NO;
    self.ScoreV.tintColor = RGBACOLOR(221, 160, 34, 1);
//    [self.ScoreV addSubview:starRatingView];
}


@end