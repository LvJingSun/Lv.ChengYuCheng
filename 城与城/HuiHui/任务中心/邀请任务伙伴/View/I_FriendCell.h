//
//  I_FriendCell.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class I_FriendFrame;

@interface I_FriendCell : UITableViewCell

+ (instancetype)I_FriendCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) I_FriendFrame *frameModel;

@end
