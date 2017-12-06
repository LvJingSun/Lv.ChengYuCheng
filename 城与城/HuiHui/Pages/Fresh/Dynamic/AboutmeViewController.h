//
//  AboutmeViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-5-13.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "PullTableView.h"

#import "ImageCache.h"

@protocol delelegate <NSObject>

- (void)deldelegate;//删除成功后返回需要刷新数据；

@end

@interface AboutmeViewController : BaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,PullTableViewDelegate>
{
    int pickerorphoto;
    int page;  // 用于分页请求的参数
    ImageCache *imagechage;
 
}

@property (nonatomic, strong) NSString  *m_typeString;

@property (nonatomic, strong) NSMutableArray  *m_LeixingArray;

@property (nonatomic, strong) NSMutableArray  *m_imageArray;

@property (nonatomic, strong) NSMutableArray  *m_CommentArray;//评价

@property (nonatomic, strong) NSMutableArray  *m_DynamicArray;//动的态列表

@property (nonatomic, strong) UIImage  *m_Picker;
@property (nonatomic, strong) UIImage  *m_Header;

@property (nonatomic, assign) int      m_deleteIndex;

@property (nonatomic, assign) BOOL     isChooseFrontCover;
// 用于临时存储用户更换背景图片的字典
@property (nonatomic, strong) NSMutableDictionary   *m_imageDic;
// 存储用户信息的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 记录选择放大的是第几张图片
@property (nonatomic, assign) int             m_index;
// 存放大图的数组
@property (nonatomic, strong) NSMutableArray  *m_BigimageArray;

// 删除某条动态
- (void)deleteDynamicRequest;


@property (unsafe_unretained,nonatomic)id<delelegate>deldele;

@end
