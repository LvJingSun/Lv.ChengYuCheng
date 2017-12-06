//
//  ZZ_FriendCell.h
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZ_FriendFrame;

@interface ZZ_FriendCell : UITableViewCell

+ (instancetype)ZZ_FriendCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) ZZ_FriendFrame *frameModel;

@end
