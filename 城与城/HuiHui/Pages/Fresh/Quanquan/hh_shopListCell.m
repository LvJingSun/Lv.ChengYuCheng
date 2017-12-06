//
//  hh_shopListCell.m
//  HuiHui
//
//  Created by mac on 15-3-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "hh_shopListCell.h"

@implementation hh_shopListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



@implementation MactQuanquanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation MactQuanDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setImageViewWithPath:(NSString *)imagePath{
    
    //    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    //    if (reSizeImage != nil) {
    //        self.m_imageView.image = reSizeImage;
    //        return;
    //    }
    //    //NSLog(@"AFImage load path: %@", path);
    //    __weak FriendsCell *weakCell = self;
    //    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
    //                            placeholderImage:[UIImage imageNamed:@"moren.png"]
    //                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
    ////                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
    //                                         self.m_imageView.image = image;
    //                                         self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
    //
    //                                         [weakCell setNeedsLayout];
    //                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
    //                                     }
    //                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
    //
    //                                         self.m_imageView.image = [UIImage imageNamed:@"moren.png"];
    //
    //                                     }];
    
    [self.m_imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]] placeholderImage:[UIImage imageNamed:@"moren.png"]];
    
}

@end