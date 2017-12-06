//
//  SceneryDetailCell.m
//  HuiHui
//
//  Created by mac on 15-1-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryDetailCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation SceneryDetailCell

@synthesize m_starView;

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        SceneryStarView *view = [[SceneryStarView alloc] initWithFrame:CGRectMake(8, 141, 110, 30) numberOfStar:5];
        
        self.m_starView = view;

    
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStarViewWithStar:(float)aValue{

    float wide = 0.0f;
    wide = aValue * self.m_starView.frame.size.width;
    self.m_starView.starForegroundView.frame = CGRectMake(0, 0, wide, self.m_starView.frame.size.height);

}

@end

@implementation SceneryPictureCell

@synthesize imageCache;

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
        self.m_leftImgV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak SceneryPictureCell *weakCell = self;
    [self.m_leftImgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                      
                                      self.m_leftImgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(90, 68)];
                                      self.m_leftImgV.contentMode = UIViewContentModeScaleToFill;
                                      [weakCell setNeedsLayout];
                                      [self.imageCache addImage:self.m_leftImgV.image andUrl:imagePath];
                                      
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];

}

- (void)setImageMiddle:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_middleImgV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak SceneryPictureCell *weakCell = self;
    [self.m_middleImgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                           placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                        
                                        self.m_middleImgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(90, 68)];
                                        self.m_middleImgV.contentMode = UIViewContentModeScaleToFill;
                                        [weakCell setNeedsLayout];
                                        [self.imageCache addImage:self.m_middleImgV.image andUrl:imagePath];
                                        
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                        
                                    }];
}

- (void)setImageRight:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_rightImgV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak SceneryPictureCell *weakCell = self;
    [self.m_rightImgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                           placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                        
                                        self.m_rightImgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(90, 68)];
                                        self.m_rightImgV.contentMode = UIViewContentModeScaleToFill;
                                        [weakCell setNeedsLayout];
                                        [self.imageCache addImage:self.m_rightImgV.image andUrl:imagePath];
                                        
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                        
                                    }];
}

@end


@implementation SceneryMapCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

@implementation SceneryNoticeCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
