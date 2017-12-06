//
//  MerchantGetCell.h
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MerchantGetFrame;

@interface MerchantGetCell : UITableViewCell

+ (instancetype)MerchantGetCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) MerchantGetFrame *frameModel;

@end
