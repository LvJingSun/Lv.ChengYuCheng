//
//  Home_MemberShipCell.h
//  HuiHui
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Home_MemberShipFrame;

@interface Home_MemberShipCell : UITableViewCell

+ (instancetype)Home_MemberShipCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Home_MemberShipFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t memberShipBlock;

@property (nonatomic, copy) dispatch_block_t dianDanBlock;

@end
