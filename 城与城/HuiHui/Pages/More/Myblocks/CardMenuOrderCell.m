//
//  CardMenuOrderCell.m
//  HuiHui
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CardMenuOrderCell.h"

@implementation CardMenuOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

@implementation CardMenuOrderCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setImageView:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.MenuImageS.image = reSizeImage;
        return;
    }
    __weak CardMenuOrderCell1 *weakCell = self;
    [self.MenuImageS setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         
                                         self.MenuImageS.image = image;
                                         [weakCell setNeedsLayout];
                                         
                                         [self.imageCache addImage:image andUrl:imagePath];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
    
}

@end

