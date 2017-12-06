//
//  BusinessOutletsViewController.h
//  baozhifu
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//  银行网点页面

#import "BaseViewController.h"
#import "AddBankCardViewController.h"

/**
 定义协议，用来实现传值代理
 */
@protocol ChosesBrachDelegate <NSObject>
/**
 此方为必须实现的协议方法，用来传值
 */
//@optional

- (void)ChosesBrachValue:(NSString *)value Brachcode:(NSString *)Brachcode;


@end

@interface BusinessOutletsViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    NSArray *items;
}

@property(strong, nonatomic) NSString *brachEnter;//入驻时候选择的


@property(strong, nonatomic) NSString *bankCode;

@property (weak, nonatomic) AddBankCardViewController *bankViewController;

/**
 此处利用协议来定义代理
 */
@property (nonatomic, unsafe_unretained) id<ChosesBrachDelegate> ChoseBrachdelegate;

@end
