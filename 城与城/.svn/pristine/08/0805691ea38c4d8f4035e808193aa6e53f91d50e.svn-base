//
//  MLNavigationController.h
//  MultiLayerNavigation
//
//  Created by Feather Chan on 13-4-12.
//  Copyright (c) 2013年 Feather Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface MLNavigationController : UINavigationController

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;

// 定义全局的变量用于其他不要手势的页面进行删除手势
@property (nonatomic, strong)  UIPanGestureRecognizer *recognizer;

// 用于导航上面滑动返回加手势的操作-进入地图页面后删除手势，进入其他的页面再添加上手势
@property (nonatomic, assign) BOOL    isMoveGesture;

@end
