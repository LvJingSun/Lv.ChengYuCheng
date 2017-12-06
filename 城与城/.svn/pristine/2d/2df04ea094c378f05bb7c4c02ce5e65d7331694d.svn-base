//
//  FriendsCell.m
//  HuiHui
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "FriendsCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation FriendsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _headerLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(headerLongPress:)];
        [self addGestureRecognizer:_headerLongPress];
    }
    return self;
}

-(void)Addpress
{
    _headerLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(headerLongPress:)];
    [self addGestureRecognizer:_headerLongPress];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setImageView:(NSString *)imagePath{
    
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
//                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
//                                         
////                                         self.m_imageView.image = image;
////                                        
////                                         self.m_imageView.contentMode = UIViewContentModeCenter;
//                                         [weakCell setNeedsLayout];
//                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
//                                     }
//                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                         
//                                     }];
    
    [self.m_imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]] placeholderImage:[UIImage imageNamed:@"moren.png"]];
    
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
    
    [self.m_imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]] placeholderImage:[UIImage imageNamed:@"moren.png"]];
    
}

- (void)headerLongPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if(_delegate && _indexPath && [_delegate respondsToSelector:@selector(cellImageViewLongPressAtIndexPathHMD:)])
        {
            [_delegate cellImageViewLongPressAtIndexPathHMD:self.indexPath];
        }
    }
}



@end


@implementation NewFriendsCell

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
    
//    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
//    if (reSizeImage != nil) {
//        self.m_imageView.image = reSizeImage;
//        return;
//    }
//    //NSLog(@"AFImage load path: %@", path);
//    __weak NewFriendsCell *weakCell = self;
//    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
//                            placeholderImage:[UIImage imageNamed:@"moren.png"]
//                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
////                                         self.m_imageView.contentMode = UIViewContentModeScaleToFill;
//                                         [weakCell setNeedsLayout];
//                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
//                                     }
//                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                         
//                                     }];
    
    [self.m_imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]] placeholderImage:[UIImage imageNamed:@"moren.png"]];

    
}


@end

@implementation NewFriendAndMeCell

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
//                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
//                                         
//                                         //                                         self.m_imageView.image = image;
//                                         //
//                                         //                                         self.m_imageView.contentMode = UIViewContentModeCenter;
//                                         [weakCell setNeedsLayout];
//                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
//                                     }
//                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                         
//                                     }];
    
    [self.m_imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]] placeholderImage:[UIImage imageNamed:@"moren.png"]];

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
//                                         //                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
//                                         
//                                         self.m_imageView.image = image;
//                                         self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
//                                         
//                                         [weakCell setNeedsLayout];
//                                         [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
//                                     }
//                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                         
//                                     }];
    
    [self.m_imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]] placeholderImage:[UIImage imageNamed:@"moren.png"]];

    
}


@end

