//
//  DynamicViewController.h
//  HuiHui
//
//  Created by mac on 13-11-21.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  动态控制器

#import "BaseViewController.h"

//#import "TitleViewController.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "ImageCache.h"

#import "PullTableView.h"

#import <CoreText/CoreText.h>

#import <QuartzCore/QuartzCore.h>

#import "PublishViewController.h"

#import "AboutmeViewController.h"

#import "ForwardingViewController.h"

#import "FriendHelper.h"



@interface DynamicViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PullTableViewDelegate,UIScrollViewDelegate,Publishdelegate,delelegate,forwarddelegate>
{
    int pickerorphoto;
    
    ImageCache *imagechage;
    
    int page;  // 用于分页请求的参数
    
    NSMutableAttributedString          *_attString;
    
    int Pingjiaindex;//选中的评价下标
    BOOL NewPingjia;
    
    int zanaddordel;//增加赞或是减掉我的赞 0 不算，1是增加我的赞，2是减去；
    int Zanindex;//选中的赞的下标；
    
    FriendHelper *friendHelper;//数据库
    
    NSString * flaseover;//表示 上传中 yes:表示上传中 no:上传结束；

    
}


// 记录导航栏显示的标题
@property (nonatomic, strong) UIButton              *m_titleBtn;

// 记录哪个类型
@property (nonatomic, strong) NSString              *m_typeString;

@property (nonatomic, strong) NSMutableArray        *m_DynamicArray;//动态列表

@property (nonatomic, strong) NSMutableArray        *m_imageArray;//每行显示图片

@property (nonatomic, strong) NSMutableArray        *m_AllMidArray;//所有的小图的图片集；用来放大加载时显示的小图；

@property (nonatomic, strong) NSMutableArray        *m_BigimageArray;//用来放大浏览图片

@property (nonatomic, strong) NSMutableArray        *m_CommentArray;//评论列表

@property (nonatomic, strong) NSMutableArray        *m_DynamicPraiseArray;//赞的人列表

//@property (nonatomic, strong) NSMutableArray        *m_ShareDynamicArray;//分享列表


// 存储用户信息的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;
// 用于临时存储用户更换背景图片的字典
@property (nonatomic, strong) NSMutableDictionary   *m_imageDic;

// 选择更换封面时，进入viewwillappear不请求数据
@property (nonatomic, assign) BOOL                  isChooseFrontCover;

@property (nonatomic, strong) NSMutableDictionary   *m_zanDic;

// 记录选择放大的是第几张图片
@property (nonatomic, assign) int             m_index;

// 会员信息请求数据
- (void)memberRequestSubmit;
// 修改用户的背景图片
- (void)modifyPictureRequest;



+(DynamicViewController*)shareobject;//保证空间只有一个；

+(void)attemptDealloc;

@end
