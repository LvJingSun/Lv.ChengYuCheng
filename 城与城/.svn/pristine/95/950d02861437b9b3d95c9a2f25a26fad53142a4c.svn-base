//
//  ForwardingViewController.h
//  HuiHui
//
//  Created by mac on 13-12-6.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  动态里转发的页面

#import "BaseViewController.h"

#import "DynamicCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "ImageCache.h"

@protocol forwarddelegate <NSObject>

- (void)forwarddelegate;//转发说说成功后返回需要刷新数据；

@end


@interface ForwardingViewController : BaseViewController<UITextViewDelegate,UIActionSheetDelegate>
{
    ImageCache *imagechage;

}

@property (nonatomic, strong) NSString              *m_typeString;

@property (nonatomic, strong) NSMutableDictionary   *m_Dyanmicdic;

@property (nonatomic, strong) NSMutableArray        *m_imageArray;

@property (nonatomic, assign) int                   m_index;

@property (unsafe_unretained,nonatomic)id<forwarddelegate>forwarddele;

@end
