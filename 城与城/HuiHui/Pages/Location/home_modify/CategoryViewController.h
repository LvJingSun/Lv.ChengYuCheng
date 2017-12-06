//
//  CategoryViewController.h
//  HuiHui
//
//  Created by mac on 14-7-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "DBHelper.h"

#import "CategoryView.h"


@interface CategoryViewController : BaseViewController<CategoryDelegate>{
    
    
    DBHelper *dbhelp;

}

// 存放分类数据的数组
@property (nonatomic, strong) NSMutableArray  *m_categoryList;

@end
