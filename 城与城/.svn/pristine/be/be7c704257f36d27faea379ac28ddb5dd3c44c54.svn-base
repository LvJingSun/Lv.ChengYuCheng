//
//  EvaluateViewController.h
//  baozhifu
//
//  Created by mac on 13-12-17.
//  Copyright (c) 2013年 mac. All rights reserved.
//  评价页面

#import "BaseViewController.h"

@interface EvaluateViewController : BaseViewController<UITextViewDelegate>{
    
    int m_textCount;
}

// 判断来自于哪个类型 1表示说两句 2表示评价
@property (nonatomic, strong) NSString  *m_typeString;

// 记录星级
@property (nonatomic, strong) NSString   *m_starString;
// 用于请求参数的商户id
@property (nonatomic, strong) NSString   *m_merchantId;

// 请求网络
- (void)requestComment;

@end
