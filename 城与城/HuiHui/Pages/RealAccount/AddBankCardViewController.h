//
//  AddBankCardViewController.h
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//  添加银行卡页面

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AddBankCardViewController : BaseViewController<UIScrollViewDelegate,UITextFieldDelegate> {
    NSString *bankStationCode;
}

@property (strong, nonatomic) NSArray *bankImages;

@property (assign, nonatomic) NSInteger currentPage;

- (void)setSelectBankStation:(NSDictionary *)info;

@end
