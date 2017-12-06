//
//  Z_SearchCell.h
//  HuiHui
//
//  Created by mac on 2017/7/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Z_SearchFrame;

@protocol Z_Search_FieldDelegate <NSObject>

- (void)PhoneFieldChange:(UITextField *)field;

@end

@interface Z_SearchCell : UITableViewCell

+ (instancetype)Z_SearchCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Z_SearchFrame *frameModel;

@property (nonatomic, strong) id<Z_Search_FieldDelegate> delegate;

@end
