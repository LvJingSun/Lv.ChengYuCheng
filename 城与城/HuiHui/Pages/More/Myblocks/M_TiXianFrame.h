//
//  M_TiXianFrame.h
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class M_TiXianModel;

@interface M_TiXianFrame : NSObject

@property (nonatomic, assign) CGRect balanceF;

@property (nonatomic, assign) CGRect jifenF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect noticeF;

@property (nonatomic, assign) CGRect needF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) M_TiXianModel *tixianModel;

@end
