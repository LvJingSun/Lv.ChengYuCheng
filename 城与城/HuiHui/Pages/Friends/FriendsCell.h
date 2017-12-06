//
//  FriendsCell.h
//  HuiHui
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

@protocol FriendsCellDelegate;
@interface FriendsCell : UITableViewCell
{
    UILongPressGestureRecognizer *_headerLongPress;
}
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) id<FriendsCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_statusLabel;

@property (weak, nonatomic) ImageCache *imageCache;

@property (weak, nonatomic) IBOutlet UILabel *m_inviteNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_imageBtn;

- (void)setImageView:(NSString *)imagePath;

- (void)setImageViewWithPath:(NSString *)imagePath;

-(void)Addpress;

@end

@protocol FriendsCellDelegate <NSObject>

- (void)cellImageViewLongPressAtIndexPathHMD:(NSIndexPath *)indexPath;

@end

@interface NewFriendsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_addBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_InviteBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_resourceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_agreeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_inNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_inPhoneLabel;

@property (weak, nonatomic) ImageCache *imageCache;

- (void)setImageView:(NSString *)imagePath;

@end



@interface NewFriendAndMeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_numberImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_numberLabel;

@property (weak, nonatomic) ImageCache *imageCache;


- (void)setImageView:(NSString *)imagePath;

- (void)setImageViewWithPath:(NSString *)imagePath;

@end


