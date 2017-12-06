//
//  PimageViewController.h
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"
//#import "CTAssetsPickerController.h"
#import "MHImagePickerMutilSelector.h"
#import "ImageCache.h"


@interface PimageViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,MHImagePickerMutilSelectorDelegate>
{
    int pickerorphoto;
    
    int selectIndexrow;//选择第几张

    BOOL Alter;//是否修改过，然后保存；
    
    NSString *option;//1：提交审核、2：删除商品、3：商品下架
    

}

// 存储图片的字典
@property (nonatomic,strong) NSMutableDictionary *m_imageDic;


// 存储是否为封面的数组
@property (nonatomic,strong) NSMutableArray *m_array;

@property (weak, nonatomic) ImageCache *imageCache;

@property (weak, nonatomic) IBOutlet UITableView *table_key_list;
@property (weak, nonatomic) IBOutlet UIView *P_tempView;
@property (weak, nonatomic) IBOutlet UIView *P_SaveView;

@property (weak, nonatomic) IBOutlet UILabel *P_label;

@property (strong, nonatomic)  NSMutableArray *Imagearray;//请求的图片数组
@property (strong, nonatomic)  NSMutableArray *Imageaddress;
@property (strong, nonatomic)  NSMutableArray *BigImageaddress;

@property (strong, nonatomic)  NSMutableDictionary *ImageDic;
@property (strong, nonatomic)  NSMutableDictionary *IscoverDic;//是否是封面


@property (strong, nonatomic)  NSMutableDictionary *AllDic;//下一步字段

//@property (weak, nonatomic)  NSString *Isediting;//编辑中
@property (weak, nonatomic) NSString *P_AddORSubmit;//新增，编辑。

@property (weak, nonatomic) NSString *P_listimage;//获取可编辑

@end
