//
//  EditorCustomerservicerViewController.h
//  HuiHui
//
//  Created by fenghq on 15/9/17.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@protocol EditorCustomerdelelegate <NSObject>
- (void)EditorCustomeraction;
@end

@interface EditorCustomerservicerViewController : BaseViewController

//1是新增2是编辑
@property (nonatomic, strong) NSString    *CustomerType;

@property (nonatomic, strong) NSMutableDictionary    *CustomerDIC;

@property(nonatomic,assign)    id <EditorCustomerdelelegate> delegate;

@end
