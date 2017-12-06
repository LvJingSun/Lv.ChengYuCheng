//
//  GetDetailCell.h
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetDetailFrame;

@interface GetDetailCell : UITableViewCell

+ (instancetype)GetDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GetDetailFrame *frameModel;

@end
