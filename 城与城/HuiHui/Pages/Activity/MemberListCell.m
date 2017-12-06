//
//  MemberListCell.m
//  baozhifu
//
//  Created by mac on 14-3-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MemberListCell.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

@implementation MemberListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageView:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imageView.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak MemberListCell *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(30, 30)];
                                     //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
                                     [weakCell setNeedsLayout];
                                     [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
    
}


@end
