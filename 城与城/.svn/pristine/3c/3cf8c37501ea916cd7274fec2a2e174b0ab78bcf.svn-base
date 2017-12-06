//
//  QuestionViewController.h
//  baozhifu
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//  选择问题页面

#import "BaseViewController.h"

@protocol QuestionDelegate <NSObject>

- (void)getValueId:(NSString *)valueId;

@end

@interface QuestionViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,QuestionDelegate> {
    //NSArray *questions;
}

@property (strong, nonatomic) NSArray *questions;

@property (weak, nonatomic) UITextField *txtQuestion;

@property (nonatomic, assign) id<QuestionDelegate> m_delegate;



// 请求数据
//- (void)questionSubmit;

@end
