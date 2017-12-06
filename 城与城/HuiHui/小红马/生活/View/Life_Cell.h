//
//  Life_Cell.h
//  HuiHui
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Life_CellFrame;

@interface Life_Cell : UITableViewCell

+ (instancetype)Life_CellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Life_CellFrame *frameModel;

@end
