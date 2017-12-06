//
//  SponsorTypeViewController.h
//  HuiHui
//
//  Created by mac on 13-12-4.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  赞助类型的界面

#import "BaseViewController.h"

@protocol TypeDelegate <NSObject>

- (void)getTypeName:(NSString *)aName;

@end

@interface SponsorTypeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *m_typeArray;

@property (nonatomic, assign) id<TypeDelegate>delegate;

@end
