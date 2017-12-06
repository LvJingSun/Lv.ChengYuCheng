//
//  SceneryNearListCell.m
//  HuiHui
//
//  Created by mac on 15-1-26.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryNearListCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation SceneryNearListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageView:(NSString *)path{
    
    UIImage *reSizeImage = [self.imageCache getImage:path];
    
    if (reSizeImage != nil) {
        self.m_showImagV.image = reSizeImage;
        return;
    }
    
    //NSLog(@"AFImage load path: %@", path);
    __weak SceneryNearListCell *weakCell = self;
    [self.m_showImagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         
                                         self.m_showImagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(120 , 90)];
                                         self.m_showImagV.contentMode = UIViewContentModeScaleToFill;
                                         [weakCell setNeedsLayout];
                                         
                                         [self.imageCache addImage:self.m_showImagV.image andUrl:path];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}


@end


@implementation SceneryPriceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
