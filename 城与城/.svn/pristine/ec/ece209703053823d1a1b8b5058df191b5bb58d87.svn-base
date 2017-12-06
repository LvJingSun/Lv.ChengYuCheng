//
//  PictureViewController.m
//  baozhifu
//
//  Created by mac on 13-11-1.
//  Copyright (c) 2013年 mac. All rights reserved.
//
#import "PictureViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AgreementViewController.h"

//#import "AppHttpClient.h"

@interface PictureViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIImageView *m_photoImageV;

@property (weak, nonatomic) IBOutlet UIButton *m_photoBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_label;

@property (weak, nonatomic) IBOutlet UIButton *m_checkBtn;

// 选择注册协议
- (IBAction)checkAgreement:(id)sender;
// 点击进入注册协议
- (IBAction)Agreement:(id)sender;


@end

@implementation PictureViewController

@synthesize registInfo;

@synthesize m_imagDic;

@synthesize isChecked;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_imagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        isChecked = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"上传头像"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_photoImageV.contentMode = UIViewContentModeCenter;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
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

- (IBAction)goback:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextStep:(id)sender {
    
    
    // 判断图片是否选择
    if ( self.m_photoImageV.image == nil ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择一张图片"];
        
        return;
    }
    
    if ( !self.isChecked ) {
        
        [SVProgressHUD showErrorWithStatus:@"请先同意注册协议"];
        
        return;
    }
 
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    if ( !self.isChecked ) {
        
        [SVProgressHUD showErrorWithStatus:@"请先同意注册协议"];
        
        return;
    }
    
    if ( [self.m_typeSteing isEqualToString:@"1"] ) {
       
        // 来自于普通注册
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [self.registInfo objectForKey:@"InviteName"],     @"RealName",
                               [self.registInfo objectForKey:@"NickName"],       @"NickName",
                               [self.registInfo objectForKey:@"Email"],          @"Email",
                               [self.registInfo objectForKey:@"PassWord"],       @"PassWord",
                               [self.registInfo objectForKey:@"smsCode"],        @"smsCode",
                               [self.registInfo objectForKey:@"InviteCode"],     @"InviteCode",
                               [self.registInfo objectForKey:@"Phone"],          @"Phone",
                               [self.registInfo objectForKey:@"PaymentPwd"],     @"PaymentPwd",
                               [self.registInfo objectForKey:@"ConfirmPaymentPwd"],@"ConfirmPaymentPwd",
                               [self.registInfo objectForKey:@"questionAnswer"],   @"questionAnswer",
                               nil];
        
        [SVProgressHUD showWithStatus:@"信息提交中"];
        
        [httpClient multiRequest:@"RegInviteSubmit.ashx" parameters:param files:self.m_imagDic success:^(NSJSONSerialization* json){
            //    [httpClient request:@"RegInviteSubmit.ashx" parameters:param success:^(NSJSONSerialization* json) {
            BOOL success = [[json valueForKey:@"status"] boolValue];
            if (success) {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
                NSArray *views = self.navigationController.viewControllers;
                [self.navigationController popToViewController:[views objectAtIndex:2] animated:YES];
            } else {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
            }
        } failure:^(NSError *error) {
            //NSLog(@"failed:%@", error);
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }];

        
    }else{
        // 来自于公众邀请码注册
     
       // [self.registInfo setObject:txtSex forKey:@"userSex"];
        
        
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [self.registInfo objectForKey:@"RealName"],       @"realName",
                               [self.registInfo objectForKey:@"NickName"],       @"nickName",
                               [self.registInfo objectForKey:@"userSex"],        @"sex",
                               [self.registInfo objectForKey:@"Email"],          @"email",
                               [self.registInfo objectForKey:@"PassWord"],       @"password",
                               [self.registInfo objectForKey:@"smsCode"],        @"smsCode",
                               [self.registInfo objectForKey:@"InviteCode"],     @"pubInvCode",
                               [self.registInfo objectForKey:@"Phone"],          @"phoneNumber",
                               [self.registInfo objectForKey:@"PaymentPwd"],     @"paymentPwd",
                               [self.registInfo objectForKey:@"ConfirmPaymentPwd"],@"confirmPaymentPwd",
                               [self.registInfo objectForKey:@"questionAnswer"],   @"questionAnswer",
                               nil];
        
        [SVProgressHUD showWithStatus:@"信息提交中"];
        
        [httpClient multiRequest:@"PublicInviteSubmit.ashx" parameters:param files:self.m_imagDic success:^(NSJSONSerialization* json){
            //    [httpClient request:@"RegInviteSubmit.ashx" parameters:param success:^(NSJSONSerialization* json) {
            BOOL success = [[json valueForKey:@"status"] boolValue];
            if (success) {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
                NSArray *views = self.navigationController.viewControllers;
                [self.navigationController popToViewController:[views objectAtIndex:2] animated:YES];
            } else {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
              
            }
        } failure:^(NSError *error) {
            //NSLog(@"failed:%@", error);
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }];

    } 
   
}

- (IBAction)m_photoChoose:(id)sender {
    
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"马上拍照",@"相册选取", nil];
    [chooseImageSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

- (void)viewDidUnload {
    [self setM_titleView:nil];
    [self setM_tempView:nil];
    [self setM_photoImageV:nil];
    [self setM_photoBtn:nil];
    [self setM_label:nil];
    [self setM_checkBtn:nil];
    [super viewDidUnload];
}

#pragma mark UIActionSheetDelegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    // 可编辑
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0://Take picture
            if ( [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] ) {
                
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //picker.
                [self presentViewController:picker animated:YES completion:nil];
                
            } else {
                
                
                [SVProgressHUD showErrorWithStatus:@"模拟器无法打开相机"];
            }
            break;
            
        case 1://From album
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
            
            break;
            
        default:
            
            break;
    }
}


#pragma 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // 为了显示状态栏的白色字体
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //=======================
    
//    if ( isIOS7 ) {
//        
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    }else{
//        
//        
//    }
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *originImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        
        // 判断当前设备的分辨率
        UIScreen *MainScreen = [UIScreen mainScreen];
        CGSize Size = [MainScreen bounds].size;
        CGFloat scale = [MainScreen scale];
        CGFloat screenWidth = Size.width * scale;
//        CGFloat screenHeight = Size.height * scale;
        
        // 根据屏幕的大小来判断图片大小要大于160
        if ( screenWidth <= 320.0 ) {
            
            if ( originImage.size.width < 160.0 || originImage.size.height < 160.0 ) {
                
                [self dismissViewControllerAnimated:YES completion:nil];

                [SVProgressHUD showErrorWithStatus:@"图片尺寸太小请重新选择"];
                
                return;
                
            }
        }else{
            
            if ( originImage.size.width < 320.0 || originImage.size.height < 320.0 ) {
                
                [self dismissViewControllerAnimated:YES completion:nil];

                [SVProgressHUD showErrorWithStatus:@"图片尺寸太小请重新选择"];
                
                return;

            }
        }

        
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
                
        
        self.m_photoImageV.image = scaleImage;
        
        [self.m_photoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [self.m_photoBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.m_label setHidden:YES];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    // 为了显示状态栏的白色字体
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //=======================
    
    
//    if ( isIOS7 ) {
//        
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    
//    }else{
//        
//        
//    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    
    // 将图片存储在字典里
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(30, 30)];
    
    UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    imgV1.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
    
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    
    imgV2.image = [CommonUtil scaleImage:image toSize:CGSizeMake(160, 160)];
        
    self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      [self getImageData:imgV],@"photoSmlUrl",
                      [self getImageData:imgV1],@"photoMidUrl",
                      [self getImageData:imgV2],@"photoBigUrl",nil];
        
    // 计算图片显示的大小
    float height = image.size.width / 160.0f;
    
    UIGraphicsBeginImageContext(CGSizeMake(160,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 160, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
}

- (IBAction)checkAgreement:(id)sender {
    
    self.isChecked = !self.isChecked;
    
    if ( self.isChecked ) {
        
        [self.m_checkBtn setImage:[UIImage imageNamed:@"comm_check_box_selected.png"] forState:UIControlStateNormal];
        
    }else{
        
        [self.m_checkBtn setImage:[UIImage imageNamed:@"comm_check_box_def.png"] forState:UIControlStateNormal];
    }

}

- (IBAction)Agreement:(id)sender {
    
    AgreementViewController *VC = [[AgreementViewController alloc]initWithNibName:@"AgreementViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}

@end
