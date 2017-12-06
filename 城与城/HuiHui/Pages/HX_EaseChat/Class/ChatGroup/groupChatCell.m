//
//  groupChatCell.m
//  HuiHui
//
//  Created by mac on 14-8-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "groupChatCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation groupChatCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageViewWithPath:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imageV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak groupChatCell *weakCell = self;
    [self.m_imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                            placeholderImage:[UIImage imageNamed:@"moren.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         //                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         
                                         self.m_imageV.image = image;
                                         self.m_imageV.contentMode = UIViewContentModeScaleAspectFit;
                                         
                                         [weakCell setNeedsLayout];
                                         [self.imageCache addImage:self.m_imageV.image andUrl:imagePath];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}


@end
