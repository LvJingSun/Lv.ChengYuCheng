//
//  HL_Promoter_DetailModel.h
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HL_Promoter_DetailModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content1;

@property (nonatomic, copy) NSString *content2;

@property (nonatomic, copy) NSString *type; //1-橙色内容 2-橙色+黑色内容 3-黑色内容 4-箭头 5-删除按钮

@end
