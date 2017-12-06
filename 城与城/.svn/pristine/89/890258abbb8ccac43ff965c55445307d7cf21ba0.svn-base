//
//  ChoseShopCell.h
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 定义协议，用来实现传值代理
 */
@protocol CellChosesshopDelegate <NSObject>
/**
 此方为必须实现的协议方法，用来传值
 */
//@optional

- (void)CellChosesshopValue:(NSString *)value code:(NSString *)shopcode;//选择店铺


@end


@interface ChoseShopCell : UITableViewCell


/**
 此处利用协议来定义代理
 */
@property (nonatomic, unsafe_unretained) id<CellChosesshopDelegate> Chosedelegate;

@property(nonatomic,weak)IBOutlet UIButton *Choseshop;

@property(nonatomic,weak)IBOutlet UILabel *shopname;

@property(nonatomic,strong)NSMutableArray *choseallnameCe;//全部的店ID,店名

@property(nonatomic,strong)NSMutableArray *chosedic;//ID
@property(nonatomic,strong)NSMutableArray *chosedicname;//


@end
