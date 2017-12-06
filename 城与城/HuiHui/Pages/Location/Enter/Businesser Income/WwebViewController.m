//
//  WwebViewController.m
//  baozhifu
//
//  Created by 冯海强 on 14-2-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "WwebViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "BusinesserlistViewController.h"
#import "AppHttpClient.h"

#import "WwebpreviewViewController.h"

@interface WwebViewController ()

@property (nonatomic,weak) IBOutlet UITextField *W_Businesser;
@property (nonatomic,weak) IBOutlet UITextField *WebNametextfield;
@property (nonatomic,weak) IBOutlet UITextField *WebWWWtextfield;
@property (nonatomic,weak) IBOutlet UIButton *WebLOGO;




@end

@implementation WwebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.imagedic=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];

    
    
    // 为了显示状态栏的白色字体
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //=======================
    
    if ( isIOS7 ) {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        
    }

    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view endEditing:YES];

    // Do any additional setup after loading the view from its nib.
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    self.WebWWWtextfield.delegate=self.WebNametextfield.delegate=self;
    
    self.title = @"微网站设置";
    
//    [self.m_WwebView setFrame:CGRectMake(0, 48, 320,[[UIScreen mainScreen]bounds].size.height)];
    [self.m_WwebView setContentSize:CGSizeMake(WindowSizeWidth,568)];
//    if (iPhone5)
//    {
//        [self.m_WwebView setCenter:CGPointMake(160,[[UIScreen mainScreen]bounds].size.height-325)];
//    }
    

    [self setRightButtonWithTitle:@"预览" action:@selector(rightClicked)];

    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)rightClicked
{
    WwebpreviewViewController * VC = [[WwebpreviewViewController alloc]initWithNibName:@"WwebpreviewViewController" bundle:nil];
    
    if (![self.WebWWWtextfield.text isEqualToString:@""]&&Imagepath!=nil) {
        VC.WXURL =self.WebWWWtextfield.text;
        VC.WXimagepath=Imagepath;
    }else{
        return;
    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;{

    [self hiddenNumPadDone:nil];
    

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.WebWWWtextfield) || (textField == self.WebNametextfield))
    {
        [textField resignFirstResponder];
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    if ([self.W_Businesser.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请先选择商户"];
        return NO;
    }
    return YES;
}


-(IBAction)ChoseMemberchant:(id)sender{
    
    DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
 
    downVC.Itemstyle = @"Business";
    downVC.Chosedelegate = self;
    
    [self.navigationController pushViewController:downVC animated:YES];

}


- (void)ChosesbusinessValue:(NSString *)value code:(NSString *)Bcode Special:(NSString *)Specialstring LimitRebate:(NSString *)LimitRebatestring RebatesType:(NSString *)RebatesTypestring; //选择商户
{
    self.W_Businesser.text =value;
    
    chosemerchantId =Bcode;
    
    [self GETwww];
    
}



-(BOOL)textNOlegth
{
    if(self.W_Businesser.text.length==0||[self.W_Businesser.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择商户"];
        
        [self.m_WwebView setContentOffset:CGPointMake(0, -15) animated:YES];
        
        return NO;
    }
    else if(self.WebNametextfield.text.length==0||[self.WebNametextfield.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写网站名称"];
        
        [self.m_WwebView setContentOffset:CGPointMake(0, 85) animated:YES];
        
        return NO;
    }
    else if(self.WebWWWtextfield.text.length==0||[self.WebWWWtextfield.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写域名地址"];
        
        [self.m_WwebView setContentOffset:CGPointMake(0, 142) animated:YES];
        
        return NO;
    }
    self.m_WwebView.bouncesZoom = NO;
    
    return YES;
    
}

//logo
-(IBAction)BusinessLogoChangeBtn:(id)sender
{
    if ([self.W_Businesser.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请先选择商户"];
        return;
    }
    
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"马上拍照",@"相册选取", nil];
    
    sheet.tag = 101;
    [sheet showInView:self.view];
    
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 101)
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
    [self.WebLOGO setImage:scaleImage forState:UIControlStateNormal];
    
}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    //    // 将图片存储在字典里
    //    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 315,500)];
    //
    //    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(315,500)];
    // 将图片存储在字典里
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.image = image;
    [self.imagedic setValue:[self getImageData:imgV] forKey:@"siteLogo"];
    
    // 计算图片显示的大小
    float height = image.size.width / 302.0f;
    UIGraphicsBeginImageContext(CGSizeMake(302,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 302, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
    
}





-(void)GETwww
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    NSString *memberId; NSString *merchantId;NSString *key;
    
    merchantId =chosemerchantId;
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           merchantId,@"merchantId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"WxSiteInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            if ([[json valueForKey:@"Code"] isEqualToString:@"0"])
            {
                code = @"0";
                self.WebNametextfield.text=self.WebWWWtextfield.text=nil;
                [self.WebLOGO setImage:[UIImage imageNamed:@"upload_button_picture.png"] forState:UIControlStateNormal];
                [self.imagedic removeAllObjects];
                [SVProgressHUD dismiss];
                
                self.navigationItem.rightBarButtonItem.enabled = NO;
                
                return ;
            }
            else if ([[json valueForKey:@"Code"] isEqualToString:@"1"])
            {
                code = @"1";
                wxsiteID =[NSString stringWithFormat:@"%@",[json valueForKey:@"SiteID"]];
                self.WebNametextfield.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"SiteName"]];
                self.WebWWWtextfield.text =[NSString stringWithFormat:@"%@",[json valueForKey:@"SecondDomain"]];
                
                NSString *path =[json valueForKey:@"Logo"];
                Imagepath = path;
                
                UIImageView*imv=[[UIImageView alloc]init];
                
                [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 220, 180)];
                    
                    imageview.image=[CommonUtil scaleImage:image toSize:CGSizeMake(220, 180)];
                    
                    [self scaleImage: imageview.image toScale:0.3];//先保存字典
                    
                    [self.WebLOGO setImage: imageview.image forState:UIControlStateNormal];
                    
                    [SVProgressHUD dismiss];

                    self.navigationItem.rightBarButtonItem.enabled = YES;

                    
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                    [self.WebLOGO setImage:[UIImage imageNamed:@"upload_button_picture.png"] forState:UIControlStateNormal];
                    [self.imagedic removeAllObjects];
                    [SVProgressHUD dismiss];
                    
                    self.navigationItem.rightBarButtonItem.enabled = NO;

                    
                }];
                
            }
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            self.navigationItem.rightBarButtonItem.enabled = NO;

        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        self.navigationItem.rightBarButtonItem.enabled = NO;

    }];
    
}





-(IBAction)BusinessLogoSaveBtn:(id)sender
{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    if ([self textNOlegth])
    {
        if (self.imagedic.count==0) {
            [SVProgressHUD showErrorWithStatus:@"请选择一张Logo"];
            return;
        }
        
        NSString *memberId; NSString *merchantId;NSString *key;
        NSString *wxsiteId; NSString *siteName; NSString *secondDomain;
        
        merchantId =chosemerchantId;
        memberId = [CommonUtil getValueByKey:MEMBER_ID];
        key = [CommonUtil getServerKey];
        
        if ([code isEqualToString:@"0"]) {
            wxsiteId =@"0";
        }else
        {
            wxsiteId = wxsiteID;
        }
        
        siteName =self.WebNametextfield.text;
        secondDomain = self.WebWWWtextfield.text;
        
        
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      memberId,@"memberId",
                                      merchantId,@"merchantId",
                                      key,@"key",
                                      wxsiteId,@"wxsiteId",
                                      siteName,@"siteName",
                                      secondDomain,@"secondDomain",
                                      
                                      nil];
        
        [SVProgressHUD showWithStatus:@"数据提交中"];
        
        [httpClient multiRequest:@"WxSiteSetUp.ashx" parameters:param files:self.imagedic success:^(NSJSONSerialization* json){
            BOOL success = [[json valueForKey:@"status"] boolValue];
            if (success) {
                [SVProgressHUD dismiss];
                NSString *msg=[json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
                
                [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(goLastView) userInfo:nil repeats:NO];
                
            } else {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }];
        
    }
    
    
}



-(void)goLastView
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
