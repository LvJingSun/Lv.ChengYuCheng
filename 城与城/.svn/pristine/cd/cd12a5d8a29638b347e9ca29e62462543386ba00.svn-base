//
//  HH_EditPhotoViewController.h
//  HuiHui
//
//  Created by mac on 14-10-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "MHImagePickerMutilSelector.h"

@protocol EditPhotoDelegate <NSObject>

- (void)photoArray:(NSMutableArray *)photoArray;

@end

@interface HH_EditPhotoViewController : BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MHImagePickerMutilSelectorDelegate>{
    
    int pickerorphoto;

}

@property (nonatomic, strong) NSMutableArray        *m_imageList;

@property (nonatomic, assign) id<EditPhotoDelegate> delegate;

// 选择图片时候用于计算view的大小
@property (nonatomic, assign) BOOL                  isChoosePhoto;
// 存放图片的字典
@property (nonatomic,strong) NSMutableDictionary    *ImageDic;

@end
