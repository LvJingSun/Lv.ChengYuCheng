//
//  New_HL_CountModel.h
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface New_HL_CountModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *type;//1-数量 2-其他

@property (nonatomic, assign) BOOL isChoose;//是否被选中

@end
