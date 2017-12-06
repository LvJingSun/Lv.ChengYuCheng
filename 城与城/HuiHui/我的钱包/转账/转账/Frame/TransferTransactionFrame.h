//
//  TransferTransactionFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TransferTransactionModel;

@interface TransferTransactionFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect bgF;

@property (nonatomic, assign) CGRect countTitleF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) TransferTransactionModel *tranModel;

@end
