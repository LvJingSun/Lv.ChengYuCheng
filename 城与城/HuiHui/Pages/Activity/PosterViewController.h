//
//  PosterViewController.h
//  baozhifu
//
//  Created by mac on 14-3-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//  海报上传

#import "BaseViewController.h"

#import "MHImagePickerMutilSelector.h"

#import "ImageCache.h"

@interface PosterViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MHImagePickerMutilSelectorDelegate,UIActionSheetDelegate,UIAlertViewDelegate>{
    
    int pickerorphoto;
    
    int selectIndexrow;
}

// 存放图片的数组
@property (nonatomic, strong) NSMutableArray        *m_imageArray;

// 存放是否设置为封面的数组
@property (nonatomic, strong) NSMutableArray        *m_array;

// 标志来自于哪个页面  1表示发起的聚会 2表示发起的活动
@property (nonatomic, strong) NSString              *m_typeString;

// 存储图片的字典
@property (strong, nonatomic)  NSMutableDictionary  *ImageDic;
@property (strong, nonatomic)  NSMutableDictionary  *IscoverDic;//是否是封面

// 上传海报用的ActivityId
@property (nonatomic, strong) NSString              *m_activeId;

// 存放编辑状态下的海报数组
@property (nonatomic,strong) NSMutableArray         *m_posterList;

@property (weak, nonatomic) ImageCache              *imageCache;

@property (nonatomic, strong) NSMutableDictionary   *m_imageDic;

// 记录是都对照片进行了处理
@property (nonatomic, assign) BOOL     isChangeImage;



// 提交请求数据
- (void)orderRequestSubmit;

@end
