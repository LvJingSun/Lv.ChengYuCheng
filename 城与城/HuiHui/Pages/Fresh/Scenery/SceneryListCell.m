//
//  SceneryListCell.m
//  HuiHui
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryListCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation SceneryListCell

@synthesize imageCache;

- (void)awakeFromNib {
    // Initialization code
    
//    self.m_imgV.frame = CGRectMake(103, 94, 217, 0.4);
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
    __weak SceneryListCell *weakCell = self;
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


@implementation SceneryChooseCell

- (void)awakeFromNib {
    // Initialization code
    
    //    self.m_imgV.frame = CGRectMake(103, 94, 217, 0.4);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
