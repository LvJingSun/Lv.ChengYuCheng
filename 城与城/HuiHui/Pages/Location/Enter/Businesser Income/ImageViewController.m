//
//  ImageViewController.m
//  Receive
//
//  Created by 冯海强 on 14-1-2.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "ImageViewController.h"
#import "CommonUtil.h"
#import "BusinesserlistViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface ImageViewController ()

@property (nonatomic,weak) IBOutlet UIButton *I_logo;//logo
@property (nonatomic,weak) IBOutlet UIButton *I_license;//营业执照

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ALLdic=[[NSMutableDictionary alloc]initWithCapacity:0];
        self.imagedic=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 为了显示状态栏的白色字体
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //=======================
    
    if ( isIOS7 ) {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        
    }
    
    [self hideTabBar:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:@"上传图片"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self.m_ImageView setContentSize:CGSizeMake(WindowSizeWidth,568)];
    
    [self AddStep4];
}


- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)AddStep4
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString * key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据检测中"];
    [httpClient request:@"MerchantAddStep.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [SVProgressHUD dismiss];
        
        if (success) {
            
            self.ALLdic = [json valueForKey:@"MerchantShopAddStep"];
     
        } else {
 
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
    
}



-(IBAction)uploadlogo:(id)sender
{
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"马上拍照",@"相册选取", nil];
    
    sheet.tag = 101;
    [sheet showInView:self.view];
    whichBtn=1;
    
}


-(IBAction)uploadphoto:(id)sender
{
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"马上拍照",@"相册选取", nil];
    
    sheet.tag = 101;
    [sheet showInView:self.view];
    whichBtn=3;
    
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==101)
    {
        //打开照相
        if (buttonIndex==0)
        {
            pickerorphoto=1;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                //imagePicker.allowsImageEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头" delegate:nil cancelButtonTitle:@"确定!" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex == 1) {
            pickerorphoto=0;
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
            
        }
    }

    
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
	[picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    if (pickerorphoto==0)
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }else if (pickerorphoto==1)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImage *scaleImage = [self scaleImage:savedImage toScale:0.3];

    if (whichBtn==1)
    {
        [self.I_logo setImage:scaleImage forState:UIControlStateNormal];
    }else if (whichBtn==3)
    {
        [self.I_license setImage:scaleImage forState:UIControlStateNormal];
    }
    
}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    // 将图片存储在字典里
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.image = image;
    if (whichBtn==1)
    {
        [self.imagedic setValue:[self getImageData:imgV] forKey:@"logoUrl"];
    }
    else if (whichBtn==3)
    {
        [self.imagedic setValue:[self getImageData:imgV] forKey:@"businessLicensePhoto"];
    }
    
    // 计算图片显示的大小
    float height = image.size.width / 220.0f;
    UIGraphicsBeginImageContext(CGSizeMake(220,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 220, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;

}


- (void)savedatatoserver
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }

    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString * merchantId = [self.ALLdic objectForKey:@"MerchantId"];
    NSString * memberBankCardID = self.memberBankCardID;
    NSString * key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           merchantId,@"merchantId",
                           key,@"key",
                           memberBankCardID,@"memberBankCardID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中……"];
    [httpClient multiRequest:@"MerchantAddStep4.ashx" parameters:param files:self.imagedic success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(RegisterOver) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}





-(IBAction)AlertWweb:(UIButton *)sender
{
    if (self.imagedic.count!=2)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择Logo或营业执照"];
        return;
    }

    [self savedatatoserver];
    
}





-(void)RegisterOver
{

    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[BusinesserlistViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}



@end
