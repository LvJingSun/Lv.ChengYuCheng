//
//  CommentCell.m
//  HuiHui
//
//  Created by mac on 13-11-25.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "CommentCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation CommentCell

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

- (void)setValue:(NSString *)aString withCount:(NSString *)aCount{
    
    if ( [aString isEqualToString:@"0"] ) {
        
        self.m_img1V.image = [UIImage imageNamed:@"star2.png"];
        self.m_img2V.image = [UIImage imageNamed:@"star2.png"];
        self.m_img3V.image = [UIImage imageNamed:@"star2.png"];
        self.m_img4V.image = [UIImage imageNamed:@"star2.png"];
        self.m_img5V.image = [UIImage imageNamed:@"star2.png"];
        
    }else{
                        
        if ( [aString isEqualToString:@"1"] ) {
            
            self.m_img1V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img2V.image = [UIImage imageNamed:@"star2.png"];
            self.m_img3V.image = [UIImage imageNamed:@"star2.png"];
            self.m_img4V.image = [UIImage imageNamed:@"star2.png"];
            self.m_img5V.image = [UIImage imageNamed:@"star2.png"];
            
            
        }else if ( [aString isEqualToString:@"2"] ){
            
            self.m_img1V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img2V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img3V.image = [UIImage imageNamed:@"star2.png"];
            self.m_img4V.image = [UIImage imageNamed:@"star2.png"];
            self.m_img5V.image = [UIImage imageNamed:@"star2.png"];
            
        }else if ( [aString isEqualToString:@"3"] ){
            
            self.m_img1V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img2V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img3V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img4V.image = [UIImage imageNamed:@"star2.png"];
            self.m_img5V.image = [UIImage imageNamed:@"star2.png"];
            
            
        }else if ( [aString isEqualToString:@"4"] ){
            
            self.m_img1V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img2V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img3V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img4V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img5V.image = [UIImage imageNamed:@"star2.png"];
            
            
        }else if ( [aString isEqualToString:@"5"] ){
            
            self.m_img1V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img2V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img3V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img4V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img5V.image = [UIImage imageNamed:@"star1.png"];
            
        }
        
    }
    
}

- (void)setImageView:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imageView.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak CommentCell *weakCell = self;
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
                                         [weakCell setNeedsLayout];
                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}



@end
