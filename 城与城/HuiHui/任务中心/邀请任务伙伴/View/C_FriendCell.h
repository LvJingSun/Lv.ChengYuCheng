//
//  C_FriendCell.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C_FriendFrame;

@protocol C_DeleteDelegate <NSObject>

- (void)deleteInvitationFriend:(UIButton *)sender;

@end

@interface C_FriendCell : UICollectionViewCell

@property (nonatomic, strong) C_FriendFrame *frameModel;

@property (nonatomic, weak) id<C_DeleteDelegate> delegate;

@end
