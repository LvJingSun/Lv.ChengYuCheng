//
//  FriDynamicViewController.h
//  HuiHui
//
//  Created by mac on 14-6-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  朋友的动态信息

#import "BaseViewController.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "ImageCache.h"

#import "PullTableView.h"

#import <CoreText/CoreText.h>

#import <QuartzCore/QuartzCore.h>

#import "ForwardingViewController.h"



@interface FriDynamicViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,PullTableViewDelegate,UIScrollViewDelegate>
{
    int pickerorphoto;
    
    ImageCache *imagechage;
    
    int page;  // 用于分页请求的参数
    
    NSMutableAttributedString          *_attString;
    
    int Pingjiaindex;//选中的评价下标
    
    BOOL NewPingjia;

}


// 记录导航栏显示的标题
@property (nonatomic, strong) UIButton              *m_titleBtn;

// 记录哪个类型
@property (nonatomic, strong) NSString              *m_typeString;

@property (nonatomic, strong) NSMutableArray        *m_DynamicArray;//动态列表

@property (nonatomic, strong) NSMutableArray        *m_imageArray;//每行显示图片

@property (nonatomic, strong) NSMutableArray        *m_BigimageArray;//用来放大浏览图片

@property (nonatomic, strong) NSMutableArray        *m_CommentArray;//评论列表


// 存储用户信息的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;
// 用于临时存储用户更换背景图片的字典
@property (nonatomic, strong) NSMutableDictionary   *m_imageDic;

@property (nonatomic, strong) NSMutableDictionary   *m_zanDic;

// 记录选择放大的是第几张图片
@property (nonatomic, assign) int                   m_index;

@property (nonatomic, strong) NSString              *m_memberId;

@property (nonatomic, strong) NSString *m_Isback;//点击头像 是否是返回

// 会员信息请求数据
- (void)memberRequestSubmit;



@end
