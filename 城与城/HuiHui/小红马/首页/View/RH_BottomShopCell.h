//
//  RH_BottomShopCell.h
//  HuiHui
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_BoFrame;

@interface RH_BottomShopCell : UITableViewCell

+ (instancetype)RH_BottomShopCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_BoFrame *frameModel;

@end
