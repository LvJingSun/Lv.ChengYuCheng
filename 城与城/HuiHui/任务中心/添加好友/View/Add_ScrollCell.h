//
//  Add_ScrollCell.h
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Add_ScrollCell : UITableViewCell

+ (instancetype)Add_ScrollCellWithTableview:(UITableView *)tableview;

//@property (nonatomic, weak) UICollectionView *collectionview;

@property (nonatomic, assign) CGFloat height;

@end
