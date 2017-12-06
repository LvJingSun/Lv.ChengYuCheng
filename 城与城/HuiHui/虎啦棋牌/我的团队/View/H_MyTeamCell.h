//
//  H_MyTeamCell.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_MyTeamFrame;

@interface H_MyTeamCell : UITableViewCell

+ (instancetype)H_MyTeamCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) H_MyTeamFrame *frameModel;

@end
