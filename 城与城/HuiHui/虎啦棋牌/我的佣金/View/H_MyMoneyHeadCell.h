//
//  H_MyMoneyHeadCell.h
//  HuiHui
//
//  Created by mac on 2017/11/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmValueChangeBlock) (NSInteger i);

@interface H_MyMoneyHeadCell : UITableViewCell

+ (instancetype)H_MyMoneyHeadCellWithTableview:(UITableView *)tableview;

@property (nonatomic, copy) NSString *selectIndex;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) SegmValueChangeBlock changeBlock;

- (void)returnChangeValue:(SegmValueChangeBlock)block;

@end
