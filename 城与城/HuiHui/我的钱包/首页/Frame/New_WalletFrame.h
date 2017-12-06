//
//  New_WalletFrame.h
//  HuiHui
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class New_WalletModel;

@interface New_WalletFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect rightF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) New_WalletModel *walletmodel;

@end
