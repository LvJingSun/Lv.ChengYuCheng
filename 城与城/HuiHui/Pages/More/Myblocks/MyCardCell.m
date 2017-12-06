//
//  MyCardCell.m
//  HuiHui
//
//  Created by 冯海强 on 14-6-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "MyCardCell.h"

@implementation MyCardCell

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
        self.CardImage.image = reSizeImage;
        return;
    }
    __weak MyCardCell *weakCell = self;

    [self.CardImage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     self.CardImage.image = image;
                                     [weakCell setNeedsLayout];

                                     [self.imageCache addImage:image andUrl:imagePath];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
    
}

@end


@implementation MyCardCell1

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
        self.BusinessImage.image = reSizeImage;
        return;
    }
    __weak MyCardCell1 *weakCell = self;

    [self.BusinessImage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                          placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                       self.BusinessImage.image = image;
                                       [weakCell setNeedsLayout];

                                       [self.imageCache addImage:image andUrl:imagePath];
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                       
                                   }];
    
}

@end



@implementation AccountProductCell

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
