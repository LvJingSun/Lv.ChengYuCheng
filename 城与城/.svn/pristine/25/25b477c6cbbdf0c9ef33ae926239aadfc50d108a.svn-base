//
//  HH_EditPhotoViewController.m
//  HuiHui
//
//  Created by mac on 14-10-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_EditPhotoViewController.h"

#import "MJPhoto.h"

#import "MJPhotoBrowser.h"

#import "CommonUtil.h"

#import "UIImageView+WebCache.h"


@interface HH_EditPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_photoView;

@property (weak, nonatomic) IBOutlet UIButton *m_choosePhotoBtn;

// 选择图片按钮触发的事件
- (IBAction)choosePhotoClicked:(id)sender;

@end

@implementation HH_EditPhotoViewController

@synthesize m_imageList;

@synthesize delegate;

@synthesize ImageDic;

@synthesize isChoosePhoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_imageList = [[NSMutableArray alloc]initWithCapacity:0];
        
        ImageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        isChoosePhoto = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(savePhoto)];
   
    
    self.m_photoView.layer.borderWidth = 1.0;
    self.m_photoView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
    // 初始化imageView
    [self getImageView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ( !self.isChoosePhoto ) {
        
        // 隐藏tabBar
        [self hideTabBar:YES];
        
    }else{
        
        // =========
//        if ( isIOS7 ) {
        
//            for(UIView *view in self.tabBarController.view.subviews)
//            {
//                
//                if([view isKindOfClass:[UITabBar class]])
//                {
//                    
//                    if (self.tabBarController.tabBar.hidden) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 0)];
//                    }
//                }
//            }
            
//        }
        //========
    }
    
    self.isChoosePhoto = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 判断是否隐藏tabBar
    if ( !self.isChoosePhoto ) {
        // 修改选择了图片后产生的bug =======
//        if ( isIOS7 ) {
        
//            for(UIView *view in self.tabBarController.view.subviews)
//            {
//                
//                if([view isKindOfClass:[UITabBar class]])
//                {
//                    
//                    if (self.tabBarController.tabBar.hidden) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 49)];
//                        
//                    }
//                }
//                
//            }
            
//        }
        
        //=========
        
        [self hideTabBar:NO];
        
    }else{
        
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)savePhoto{
    
    if ( delegate && [delegate respondsToSelector:@selector(photoArray:)] ) {
        
        [delegate photoArray:self.m_imageList];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)choosePhotoClicked:(id)sender {

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"马上拍照",@"相册选择", nil];
    
    sheet.tag = 100;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];

}

// 获取图片
- (void)getImageView{
    
    // 先清空view里面的所有控件
    for (id view in self.m_photoView.subviews) {
        [view removeFromSuperview];
    }
    
    int BtnW = 65;
    int BtnWS = 7;
    int BtnX = 10;
    
    int BtnH = 65;
    int BtnHS = 10;
    int BtnY = 10;
    
    int i = 0;
    
    for (i = 0; i < [m_imageList count]; i++ ) {
        
        NSLog(@"clas = %@,self.m_imageList = %@",[[m_imageList objectAtIndex:i] class],self.m_imageList);

        
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake( (BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH );
        imageview.tag = 10000 + i;
        imageview.userInteractionEnabled = YES;
        // 内容模式
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
        
        // 判断图片是URL还是image类型
        if ( [[self.m_imageList objectAtIndex:i] isKindOfClass:[UIImage class]] ) {
            
             imageview.image = [self.m_imageList objectAtIndex:i];
      
        }else{
            
            
            [imageview setImageWithURL: [NSURL URLWithString: [m_imageList objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"TopViewRight.png"]];

        }
    
        // 添加图片手势
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)]];
        
       
        // 删除图片的按钮
        UIButton *btn_delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_delete setFrame:CGRectMake(0, 0, 25, 25)];
        btn_delete.backgroundColor = [UIColor clearColor];
        [btn_delete setImage:[UIImage imageNamed:@"red_wrong.png"] forState:UIControlStateNormal];
        [btn_delete setCenter:CGPointMake(55, 10)];
        [btn_delete addTarget:self action:@selector(deletePicHandler:) forControlEvents:UIControlEventTouchUpInside];
        [btn_delete setTag:i];
        [imageview addSubview:btn_delete];
        
        [self.m_photoView addSubview:imageview];
        
    }
    
    int getEndImageYH = (BtnH + BtnHS) * (i/4) + BtnY;
    
    // 设置添加图片的按钮
    UIButton * AddBtn  = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 80, 80)];
    AddBtn.frame = CGRectMake((BtnW+BtnWS) * (i%4) + BtnX, (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH);
    [AddBtn setBackgroundImage:[UIImage imageNamed:@"addicon.png"] forState:UIControlStateNormal];
    [AddBtn addTarget:self action:@selector(choosePhotoClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 显示数量的label
    UILabel *Numlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    Numlabel.center = CGPointMake(32, 10);
    Numlabel.textColor = [UIColor lightGrayColor];
    Numlabel.textAlignment = UITextAlignmentRight;
    [Numlabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    [AddBtn addSubview:Numlabel];
    [self.m_photoView addSubview:AddBtn];
    
    Numlabel.text = [NSString stringWithFormat:@"%d/9",self.m_imageList.count];
    
    if ( self.m_imageList.count > 0 && self.m_imageList.count < 4) {
        
        Numlabel.hidden = NO;
        AddBtn.hidden = NO;
        
        self.m_photoView.frame = CGRectMake(self.m_photoView.frame.origin.x, self.m_photoView.frame.origin.y, self.m_photoView.frame.size.width, 85);
        
    }else if ( self.m_imageList.count >= 4 && self.m_imageList.count < 8 ){
        
        Numlabel.hidden = NO;
        AddBtn.hidden = NO;
        
        self.m_photoView.frame = CGRectMake(self.m_photoView.frame.origin.x, self.m_photoView.frame.origin.y, self.m_photoView.frame.size.width, 160);
        
    } else if ( self.m_imageList.count >= 8 && self.m_imageList.count <= 9 ){
        
        if ( self.m_imageList.count == 8 ) {
            
            Numlabel.hidden = NO;
            AddBtn.hidden = NO;
            
        }else{
            
            Numlabel.hidden = YES;
            AddBtn.hidden = YES;
        }
        
        self.m_photoView.frame = CGRectMake(self.m_photoView.frame.origin.x, self.m_photoView.frame.origin.y, self.m_photoView.frame.size.width, getEndImageYH + 75);
        
    }
    
}

- (void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag==%d", imageTap.view.tag);
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.m_imageList count]];
    
    for (int i = 0; i < [self.m_imageList count]; i++) {
        // 替换为中等尺寸图片
        
        MJPhoto *photo = [[MJPhoto alloc] init];

        
        // 判断图片是URL还是image类型
        if ( [[self.m_imageList objectAtIndex:i] isKindOfClass:[UIImage class]] ) {
            
            photo.image = [self.m_imageList objectAtIndex:i];
            
        } else{
            
            NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [self.m_imageList objectAtIndex:i]];
            photo.url = [NSURL URLWithString: getImageStrUrl]; // 图片路径
            
            NSLog(@"clas = %@",[getImageStrUrl class]);
            
        }
       
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
        
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}

#pragma mark - UIActionSheetDelegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100)
    {
        //打开照相
        if (buttonIndex == 0)
        {
            self.isChoosePhoto = YES;
            
            pickerorphoto = 1;
            
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                
                self.isChoosePhoto = NO;
                
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"本设备暂不支持拍照功能"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }else if (buttonIndex == 1) {
            
            //打开相册
            
            self.isChoosePhoto = YES;
            
            pickerorphoto = 0;
            
            MHImagePickerMutilSelector* imagePickerMutilSelector = [MHImagePickerMutilSelector standardSelector];//自动释放
            imagePickerMutilSelector.Allnum = [NSString stringWithFormat:@"%d",self.m_imageList.count];
            
            imagePickerMutilSelector.delegate=self;//设置代理
            
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.delegate = imagePickerMutilSelector;//将UIImagePicker的代理指向到imagePickerMutilSelector
            [picker setAllowsEditing:NO];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            picker.navigationController.delegate=imagePickerMutilSelector;//将UIImagePicker的导航代理指向到imagePickerMutilSelector
            imagePickerMutilSelector.imagePicker = picker;//使imagePickerMutilSelector得知其控制的UIImagePicker实例，为释放时需要。
            [self presentModalViewController:picker animated:YES];
            
        }
    }
}

- (void)deletePicHandler:(UIButton*)btn
{
    [self.view endEditing:YES];
    
    for(UIButton * tmpView in self.m_photoView.subviews)
    {
        [tmpView removeFromSuperview];
        
    }
    
    [self.m_imageList removeObjectAtIndex:btn.tag];
    
    
    [self getImageView];
    
}

#pragma mark - Assets Picker Delegate
- (void)imagePickerMutilSelectorDidGetImages:(NSArray *)imageArray
{
    CGRect rx = [ UIScreen mainScreen ].bounds;
    
    
    NSLog(@"imageArray = %i",imageArray.count);
    
    if ( imageArray.count == 0 ) {
        
        return;
    }
    
    NSLog(@"self.m_imageList = %i",self.m_imageList.count);
    
    NSArray *importItems = [[NSArray alloc] initWithArray:imageArray copyItems:YES];
    
    for (int i = 0; i < importItems.count; i++) {
        
        UIImage * image = [importItems objectAtIndex:i];
        
        if (image.size.width > rx.size.width||image.size.height>rx.size.height) {
            
            UIImage * image2 = [[UIImage alloc]init];
            
            image2 =  [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSize.size.width, WindowSize.size.width*image.size.height/image.size.width)];
            
            [self.m_imageList addObject:image2];
            
        }else{
            
            [self.m_imageList addObject:image];
            
        }
        
    }
    
    
    [self getImageView];
    
    
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - image picker delegte
//拍照
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    
    if (pickerorphoto == 0)
    {
        //        image = [info objectForKey:UIImagePickerControllerEditedImage];
        
    }else if (pickerorphoto == 1){
        
        // 表示拍照的图片
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        UIImage * imagenew = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSize.size.width, WindowSize.size.width*image.size.height/image.size.width)];
        
        NSData *imageData = UIImageJPEGRepresentation(imagenew,0.4f);
        
        
        [self.m_imageList addObject:[UIImage imageWithData:imageData]];
        
        [self getImageView];
        
        
        
    }
    
    
}

- (NSData *)getImageData:(UIImageView *)imageView {
    
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
    
}

//循环加到字典中
- (void)ImageFromArrayToDic
{
    
    for (int i = 0; i < self.m_imageList.count; i++) {
        
        UIImageView *imgV = [[UIImageView alloc]init];
        
        imgV.image = [self.m_imageList objectAtIndex:i];
        
        [self.ImageDic setValue:[self getImageData:imgV] forKey:[NSString stringWithFormat:@"picUrl%d",i]];
        
    }
    
}

@end
