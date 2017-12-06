//
//  M_Record_Frame.h
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class M_Record_Model;

@interface M_Record_Frame : NSObject

@property (nonatomic, assign) CGRect typeF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) M_Record_Model *recordModel;

@end
