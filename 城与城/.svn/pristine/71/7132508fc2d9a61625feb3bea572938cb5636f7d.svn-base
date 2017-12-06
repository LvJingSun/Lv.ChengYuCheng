//
//  MyPartyCell.m
//  baozhifu
//
//  Created by mac on 14-3-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyPartyCell.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

@implementation MyPartyCell

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
        self.m_imagV.image = reSizeImage;
        return;
    }
    
    self.m_imagV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.m_imagV.layer.borderWidth = 1.0;
    
    //NSLog(@"AFImage load path: %@", path);
    __weak MyPartyCell *weakCell = self;
    [self.m_imagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     self.m_imagV.image = image; //[CommonUtil scaleImage:image toSize:CGSizeMake(70, 105)];
                                     self.m_imagV.contentMode = UIViewContentModeScaleAspectFit;
                                     [weakCell setNeedsLayout];
                                     [self.imageCache addImage:self.m_imagV.image andUrl:imagePath];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
    
}



@end
