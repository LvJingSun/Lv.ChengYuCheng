//
//  HL_CommitPromoterModel.h
//  HuiHui
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HL_CommitPromoterModel : NSObject

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *notice;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *type; //0-添加 1-修改

@end
