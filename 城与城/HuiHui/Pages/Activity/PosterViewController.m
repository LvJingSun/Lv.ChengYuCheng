//
//  PosterViewController.m
//  baozhifu
//
//  Created by mac on 14-3-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "PosterViewController.h"

#import "UIImageView+AFNetworking.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "PimageCell.h"

#import "AppHttpClient.h"

#import "UIImageView+AFNetworking.h"

#import "AppDelegate.h"

@interface PosterViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIButton *m_btn;

@property (weak, nonatomic) IBOutlet UIView *m_imageView;

@property (strong, nonatomic) IBOutlet UIView *m_footerVIew;


// 返回按钮触发的事件
- (IBAction)goBackLast:(id)sender;

// 选择海报上传
- (IBAction)choosePicture:(id)sender;
// 上传海报
- (IBAction)submitPicture:(id)sender;

@end

@implementation PosterViewController

@synthesize m_imageArray;

@synthesize m_array;

@synthesize ImageDic;

@synthesize IscoverDic;

@synthesize m_imageDic;

@synthesize isChangeImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        ImageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        IscoverDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        isChangeImage = NO;
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setTitle:@"上传海报"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"选择" action:@selector(rightClicked)];
    
    // 当海报数组不为0的时候表示是编辑状态
    if ( self.m_posterList.count != 0 ) {
        
        [SVProgressHUD showWithStatus:@"图片加载中……"];
        
        for (int i = 0; i < self.m_posterList.count; i ++) {
            
            NSDictionary *data = [self.m_posterList objectAtIndex:i];
            
            NSString *path = [data objectForKey:@"BigPoster"];
            
            UIImageView*imv=[[UIImageView alloc]init];
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 450,280)];
                [self.imageCache addImage:imgV.image andUrl:path];
                UIImage *scaleImage = [self scaleImage:[CommonUtil scaleImage:image toSize:CGSizeMake(450, 280)] toScale:0.3];
                
                [self.m_imageDic setObject:scaleImage forKey:path];
                
                if ( self.m_imageDic.count == self.m_posterList.count )
                {
                    [self getDic];
                    
                }
                
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
                [SVProgressHUD showErrorWithStatus:@"资源不存在或已丢失!"];
                
            }];
        }

    }else{
        
        // 隐藏tableView, 显示按钮
        self.m_tableView.hidden = YES;
        
        self.m_imageView.hidden = NO;
    }
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    [self hideTabBar:YES];

    // 为了显示状态栏的白色字体
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //=======================
    
    if ( isIOS7 ) {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)rightClicked{

    // 选择图片
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil
                                         delegate:self
                                cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                                otherButtonTitles:@"马上拍照",@"相册选取", nil];
    sheet.tag = 100;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

//重新整理图片；
- (void)getDic{
    
    for (int i = 0; i < self.m_posterList.count; i ++) {
        
        NSDictionary *dic = [self.m_posterList objectAtIndex:i];
        
        [self.m_imageArray addObject:[self.m_imageDic objectForKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"BigPoster"]]]];
        [self.m_array addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"IsFrontCover"]]];
        
        if ( i == self.m_posterList.count - 1 ) {
            
            [SVProgressHUD dismiss];

            self.m_imageView.hidden = YES;

            self.m_tableView.hidden = NO;
            
            self.m_tableView.tableFooterView = self.m_footerVIew;

            [self.m_tableView reloadData];
            
        }
        
    }
    
}

- (IBAction)choosePicture:(id)sender {
    
    
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil
                                         delegate:self
                                cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                                otherButtonTitles:@"马上拍照",@"相册选取", nil];
    sheet.tag = 100;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

- (IBAction)submitPicture:(id)sender {
    
    // 上传海报，提交审核
    [self imageRequestSubmit];
    
}

#pragma mark - UIActionDelegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( actionSheet.tag == 100 ) {
        
        //打开照相
        if (buttonIndex == 0)
        {
            
            pickerorphoto = 1;
            if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                //imagePicker.allowsImageEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"本设备暂不支持拍照" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex == 1) {
            pickerorphoto = 0;
            
            MHImagePickerMutilSelector* imagePickerMutilSelector=[MHImagePickerMutilSelector standardSelector];//自动释放
            imagePickerMutilSelector.delegate=self;//设置代理
            
            UIImagePickerController* picker=[[UIImagePickerController alloc] init];
            picker.delegate=imagePickerMutilSelector;//将UIImagePicker的代理指向到imagePickerMutilSelector
            [picker setAllowsEditing:NO];
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            picker.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
            picker.navigationController.delegate=imagePickerMutilSelector;//将UIImagePicker的导航代理指向到imagePickerMutilSelector
            imagePickerMutilSelector.imagePicker=picker;//使imagePickerMutilSelector得知其控制的UIImagePicker实例，为释放时需要。
            [self presentModalViewController:picker animated:YES];
            
            
        }

    }else if ( actionSheet.tag == 101 ){
        
        self.isChangeImage = YES;

        if ( buttonIndex == 0 ) {
            // 删除照片
            [self.ImageDic removeAllObjects];
            [self.IscoverDic removeAllObjects];
            [self.m_imageArray removeObjectAtIndex:selectIndexrow];
            [self.m_array removeObjectAtIndex:selectIndexrow];
            
            if ( self.m_imageArray.count == 0 ) {
                
                self.m_tableView.hidden = YES;
                
                self.m_imageView.hidden = NO;
                
                
            }
            
            [self.m_tableView reloadData];

            
        }else if ( buttonIndex == 1 ) {
            
            self.isChangeImage = YES;

            // 设置为封面
            // 选择某个设置为封面就将数组里的该值设置为1,其他的为0
            for (int i = 0; i < self.m_array.count; i ++) {
                
                if ( selectIndexrow == i ) {
                    
                    [self.m_array replaceObjectAtIndex:selectIndexrow withObject:@"1"];
                    
                }else{
                    
                    [self.m_array replaceObjectAtIndex:i withObject:@"0"];
                    
                }
            }
            
            
            [self.m_tableView reloadData];
            
        }else{
            
            
        }
        
    }
}

- (void)imageRequestSubmit{
    
    if (self.m_array.count!=0)
    {
        int count=0;
        for (int i=0; i<self.m_array.count; i++)
        {
            if ([[self.m_array objectAtIndex:i]isEqualToString:@"1"])
            {
                break;
            }
            else
            {
                count++;
            }
        }
        if (count==self.m_array.count)
        {
            [SVProgressHUD showErrorWithStatus:@"请选择一张封面"];
            return;
        }
    }
    
    
    
    [self.IscoverDic removeAllObjects];
    
    for (int i=0; i<self.m_imageArray.count; i++)
    {
        [self SavescaleImage:[self.m_imageArray objectAtIndex:i] indexpath:i+1];
        
        [self.IscoverDic setObject:[NSString stringWithFormat:@"%@",[self.m_array objectAtIndex:i]] forKey:[NSString stringWithFormat:@"IsFrontCover%d",i+1]];
        
    }
    
    
//    if ( self.m_posterList.count == self.m_imageArray.count ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"您还未修改过海报！"];
//        
//        return;
//    }
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",self.m_activeId],@"activityId",
                                  [NSString stringWithFormat:@"%i",[self.m_imageArray count]],@"picCount",
                                  nil];
    
    [param addEntriesFromDictionary:[NSDictionary dictionaryWithDictionary:self.IscoverDic]];
   
    AppHttpClient* httpClient = [AppHttpClient sharedClient];

    [SVProgressHUD showWithStatus:@"数据提交中"];
  
    [httpClient multiRequest:@"ActivityPosterAdd.ashx" parameters:param files:self.ImageDic success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
//            NSString *msg=[json valueForKey:@"msg"];
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"海报上传成功，提交审核" delegate:self cancelButtonTitle:@"下一次" otherButtonTitles:@"立即提交", nil];
            alertView.tag = 123098;
            [alertView show];
            
//            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(SaveDataOver) userInfo:nil repeats:NO];

            
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

// 提交请求数据
- (void)orderRequestSubmit{
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    // operation 1 删除  2 提交
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  @"2",@"operation",
                                  [NSString stringWithFormat:@"%@",self.m_activeId],@"actId",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityOptions.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            NSLog(@"%@",msg);
            
            if ( [self.m_typeString isEqualToString:@"1"] ) {
                
                // 聚会 - 返回列表
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 4] animated:YES];
                
            }else{
                // 活动 - 返回列表
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 5] animated:YES];
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}


#pragma mark - Assets Picker Delegate
- (void)imagePickerMutilSelectorDidGetImages:(NSArray *)imageArray
{
    
    self.isChangeImage = YES;
    
    // 存储是否为封面的值在数组里面
    for (int i = 0; i < imageArray.count; i++) {
        
        [self.m_array addObject:@"0"];
    }
    
    self.m_tableView.hidden = NO;
    
    self.m_imageView.hidden = YES;
    
    NSArray *importItems = [[NSArray alloc] initWithArray:imageArray copyItems:YES];
//    Alter=YES;
    
    [self.m_imageArray addObjectsFromArray:importItems];
    
    for (UIImage *image in self.m_imageArray) {
        
        NSLog(@"%f,%f",image.size.width,image.size.height);
    }
    
    // 设置tableView的footerView
    if ( self.m_imageArray.count != 0 ) {
        
        self.m_tableView.tableFooterView = self.m_footerVIew;
        
    }
    
    
    [self.m_tableView reloadData];
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.isChangeImage = YES;

    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
  
    if (pickerorphoto == 0){
   
        image = [info objectForKey:UIImagePickerControllerEditedImage];
   
    }else if (pickerorphoto==1) {
      
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
   
    }
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImage *scaleImage = [self scaleImage:savedImage toScale:0.3];
    
    
    self.m_tableView.hidden = NO;
    self.m_imageView.hidden = YES;
    
    [self.m_imageArray addObject:scaleImage];
    [self.m_array addObject:@"0"];
    
    // 设置tableView的footerView
    if ( self.m_imageArray.count != 0 ) {
        
        self.m_tableView.tableFooterView = self.m_footerVIew;
        
    }
    
    
    [self.m_tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.m_imageArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    PimageCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
       
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"PimageCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
    
    }
    
    cell.P_Cellimageicon.hidden=YES;
    
    if ( self.m_imageArray.count != 0 ) {
        
        UIImage *scaleImage = [self scaleImage:[self.m_imageArray objectAtIndex:indexPath.row] toScale:0.3];
        
        cell.P_Cellimage.image = scaleImage;
        
        if ( [[self.m_array objectAtIndex:indexPath.row]isEqualToString:@"1"] )
        {
            cell.P_Celltext.text = @"封面图片";
            cell.P_Cellimageicon.hidden = NO;
            selectIndexrow = indexPath.row;
        }

    }
    

    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 85.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    selectIndexrow = indexPath.row;
 
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除照片",@"设为封面", nil];
    sheet.tag = 101;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
        
    // 计算图片显示的大小
    float height = image.size.width / 180.0f;
    UIGraphicsBeginImageContext(CGSizeMake(180,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 180, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize withWidth:(float)aWidth{
    
    // 计算图片显示的大小
    float height = image.size.width / aWidth;
    UIGraphicsBeginImageContext(CGSizeMake(aWidth,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, aWidth, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

-(UIImage *)SavescaleImage:(UIImage *)image indexpath:(int)row
{
    
    float height1 = image.size.width / 65.0f;
    
    UIImageView *imageVV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, image.size.height / height1)];
    
    imageVV.image = [self scaleImage:image toScale:0.3 withWidth:65.0f];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 105)];
    
    imageV.backgroundColor = [UIColor whiteColor];
    
    imageV.image = imageVV.image;
    
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    
    imageV.frame = CGRectMake(0, 0, 65, 105);
    
    
    
    
    float height2 = image.size.width / 139.0f;

    UIImageView *imageVV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 139, image.size.height / height2)];
    
    imageVV1.image = [self scaleImage:image toScale:0.3 withWidth:139.0f];
    
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 139, 223)];
    
    imageV1.backgroundColor = [UIColor whiteColor];
    
    imageV1.image = imageVV1.image;
    
    imageV1.contentMode = UIViewContentModeScaleAspectFit;
    
    imageV1.frame = CGRectMake(0, 0, 139, 223);
    
    
    
   
    float height3 = image.size.width / 280.0f;

    UIImageView *imageVV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, image.size.height / height3)];
    
    imageVV2.image = [self scaleImage:image toScale:0.3 withWidth:280.0f];
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 450)];
    
    imageV2.backgroundColor = [UIColor whiteColor];
    
    imageV2.image = imageVV2.image;
    
    imageV2.contentMode = UIViewContentModeScaleAspectFit;
    
    imageV2.frame = CGRectMake(0, 0, 280, 450);
    
    
//    // 将图片存储在字典里
//    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 105)];
//    
//    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(65, 105)];
//    
//    UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 139, 223)];
//    
//    imgV1.image = [CommonUtil scaleImage:image toSize:CGSizeMake(139, 223)];
//    
//    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 450)];
//    
//    imgV2.image = [CommonUtil scaleImage:image toSize:CGSizeMake(280, 450)];
    
    [self.ImageDic setObject:[self getImageData:imageV] forKey:[NSString stringWithFormat:@"actSmlUrl%d",row]];
    [self.ImageDic setObject:[self getImageData:imageV1] forKey:[NSString stringWithFormat:@"actMidUrl%d",row]];
    [self.ImageDic setObject:[self getImageData:imageV2] forKey:[NSString stringWithFormat:@"actBigUrl%d",row]];
    
    
    float height = image.size.width / 180.0f;
    UIGraphicsBeginImageContext(CGSizeMake(180,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 180, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 123098 ) {
        if ( buttonIndex == 1 ) {
            // 立即提交审核
            [self orderRequestSubmit];
            
        }else{
            
            if ( [self.m_typeString isEqualToString:@"1"] ) {
                
                // 聚会 - 返回列表
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 4] animated:YES];
                
            }else{
                // 活动 - 返回列表
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 5] animated:YES];
                
                
            }
            
            
           
            
        }
    }else if ( alertView.tag == 1005 ){
        
        if ( buttonIndex == 1 ) {
            
            if (self.m_array.count!=0)
            {
                int count=0;
                for (int i=0; i<self.m_array.count; i++)
                {
                    if ([[self.m_array objectAtIndex:i]isEqualToString:@"1"])
                    {
                        break;
                    }
                    else
                    {
                        count++;
                    }
                }
                if (count==self.m_array.count)
                {
                    [SVProgressHUD showErrorWithStatus:@"请选择一张封面"];
                    return;
                }
            }
            
            [self.IscoverDic removeAllObjects];
            
            for (int i=0; i<self.m_imageArray.count; i++)
            {
                [self SavescaleImage:[self.m_imageArray objectAtIndex:i] indexpath:i+1];
                
                [self.IscoverDic setObject:[NSString stringWithFormat:@"%@",[self.m_array objectAtIndex:i]] forKey:[NSString stringWithFormat:@"IsFrontCover%d",i+1]];
                
            }
        
            
            // 判断网络是否存在
            if ( ![self isConnectionAvailable] ) {
                
                return;
            }
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            NSString *key = [CommonUtil getServerKey];
            NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          memberId,     @"memberId",
                                          key,   @"key",
                                          [NSString stringWithFormat:@"%@",self.m_activeId],@"activityId",
                                          [NSString stringWithFormat:@"%i",[self.m_imageArray count]],@"picCount",
                                          nil];
            
            [param addEntriesFromDictionary:[NSDictionary dictionaryWithDictionary:self.IscoverDic]];
            
            AppHttpClient* httpClient = [AppHttpClient sharedClient];
            
            [SVProgressHUD showWithStatus:@"数据提交中"];
            
            [httpClient multiRequest:@"ActivityPosterAdd.ashx" parameters:param files:self.ImageDic success:^(NSJSONSerialization* json){
                BOOL success = [[json valueForKey:@"status"] boolValue];
                if (success) {
                    
                    Appdelegate.isModifyImage = YES;

                    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    
                    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(lastView) userInfo:nil repeats:NO];
                    
                } else {
                    NSString *msg = [json valueForKey:@"msg"];
                    [SVProgressHUD showErrorWithStatus:msg];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            }];

        }else{
            
            // 取消的话则不作任何操作
            Appdelegate.isModifyImage = NO;

            [self lastView];
        }
    }
    
}

- (IBAction)goBackLast:(id)sender {
    
    if ( isChangeImage ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"您对海报进行了修改,记得重新上传哦"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"保存",nil];
        alert.tag = 1005;
        [alert show];

    }else{
        
        [self lastView];
    }
}

- (void)lastView{
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end

