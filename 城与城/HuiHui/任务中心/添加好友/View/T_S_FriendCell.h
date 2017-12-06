//
//  T_S_FriendCell.h
//  HuiHui
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class T_S_FriendFrame;

@interface T_S_FriendCell : UITableViewCell

+ (instancetype)T_S_FriendCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) T_S_FriendFrame *frameModel;

@end
