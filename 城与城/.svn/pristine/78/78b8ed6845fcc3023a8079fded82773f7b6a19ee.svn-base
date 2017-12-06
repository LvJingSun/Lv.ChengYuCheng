//
//  FirstListViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-3-26.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ImageCache.h"

/**
 定义协议，用来实现传值代理
 */
@protocol PhotoDelegate <NSObject>

/**
 此方为必须实现的协议方法，用来传值
 */
- (void)changeValue:(NSString *)minURL second:(NSString *)valueID;

@end

@interface FirstListViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) ImageCache *imageCache;
@property (strong, nonatomic)  NSMutableDictionary *ImageDiction;
@property(nonatomic, weak) NSString *MemberchantID;//商户ID

@property (nonatomic ,strong) NSMutableArray * fistphotoarray;

@property (strong, nonatomic)  NSMutableDictionary *ImageDic;
@property (nonatomic ,strong) NSMutableArray * NewarrayID;//重新整理数据
@property (nonatomic ,strong) NSMutableArray * NewarrayImg;//重新整理数据



@property (nonatomic ,strong) NSString * ChoseBtn;//选择的图片
/**
 此处利用协议来定义代理
 */
@property (nonatomic, unsafe_unretained) id<PhotoDelegate> delegate;


@end

