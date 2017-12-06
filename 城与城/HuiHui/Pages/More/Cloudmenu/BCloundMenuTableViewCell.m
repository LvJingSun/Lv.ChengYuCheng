//
//  BCloundMenuTableViewCell.m
//  HuiHui
//
//  Created by 冯海强 on 15-5-21.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BCloundMenuTableViewCell.h"

#import "UIImageView+AFNetworking.h"


@implementation BCloundMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
@implementation BCloundMenuTableViewCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.m_Btn.layer.masksToBounds = YES;
    self.m_Btn.layer.cornerRadius = 8.0;
    // Configure the view for the selected state
}

@end
@implementation BCloundMenuTableViewCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.m_numImgV.layer.masksToBounds = YES;
    self.m_numImgV.layer.cornerRadius = 5.0;
    // Configure the view for the selected state
}

- (void)setImagePath:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_numImgV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak BCloundMenuTableViewCell2 *weakCell = self;
    [self.m_numImgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     
                                     self.m_numImgV.image = image; //[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
//                                     self.m_numImgV.contentMode = UIViewContentModeScaleToFill;
                                     [weakCell setNeedsLayout];
                                     
                                     [self.imageCache addImage:self.m_numImgV.image andUrl:imagePath];
                                     
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
    
}

@end




@implementation BCloundMenuTableViewCell3

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.m_Btn.layer.masksToBounds = YES;
    self.m_Btn.layer.cornerRadius = 8.0;
    // Configure the view for the selected state
}



@end