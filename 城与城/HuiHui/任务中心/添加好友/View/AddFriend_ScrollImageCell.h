//
//  AddFriend_ScrollImageCell.h
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriend_ScrollImageCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

+ (instancetype)AddFriend_ScrollImageCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *collectArray;

@property (nonatomic, assign) CGFloat height;

@end
