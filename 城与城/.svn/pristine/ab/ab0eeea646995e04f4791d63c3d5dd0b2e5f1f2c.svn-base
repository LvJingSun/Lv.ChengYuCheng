//
//  FirstListCell.m
//  HuiHui
//
//  Created by 冯海强 on 14-3-26.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FirstListCell.h"

#import "UIImageView+AFNetworking.h"

@implementation FirstListCell

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

@end


@implementation AdvertListCell

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
    
    // 设置imageView的坐标
    self.m_imageView.frame = CGRectMake(self.m_imageView.frame.origin.x, self.m_imageView.frame.origin.y, WindowSizeWidth, self.m_imageView.frame.size.height);
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imageView.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
//    self.m_imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.m_imageView.layer.borderWidth = 1.0;
    
    __weak AdvertListCell *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     self.m_imageView.image = image;// [CommonUtil scaleImage:image toSize:CGSizeMake(70, 105)];
//                                     self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
                                     [weakCell setNeedsLayout];
                                     [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
    
}

@end
