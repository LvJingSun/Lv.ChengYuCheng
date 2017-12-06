//
//  FirstPhotoViewController.m
//  baozhifu
//
//  Created by 冯海强 on 14-3-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FirstPhotoViewController.h"
#import "CommonUtil.h"
#import "FirstListViewController.h"
#import "SVProgressHUD.h"

@interface FirstPhotoViewController ()

@end

@implementation FirstPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setTitle:self.MemberchantName];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self getPhoto];
    self.bootPageImagesID = @"null";

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:YES];
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getPhoto
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId;NSString *key;
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    key = [CommonUtil getServerKey];
    
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           self.MemberchantID,@"merchantId",
                           key,@"key",
                           nil];
    [SVProgressHUD showWithStatus:@"图片加载中"];
    [httpClient request:@"BootPagerDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];

            NSArray * array =[json valueForKey:@"BootPageImageList"];
            NSDictionary * dic =[array objectAtIndex:0];
            
            
            NSString *path = [dic objectForKey:@"MinBgImg"];
            
            UIImageView*imv=[[UIImageView alloc]init];
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                
                UIImage *scaleImage = [CommonUtil scaleImage:image toSize:CGSizeMake(230, 290)];
                [self.ImageBtn setImage:scaleImage forState:UIControlStateNormal];
                
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
                [SVProgressHUD showErrorWithStatus:@"资源不存在或已丢失!"];
                
            }];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
    
}



//logo
-(IBAction)BusinessLogoChangeBtn:(id)sender
{
    
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我的引导库",nil];
    
    sheet.tag = 1;
    [sheet showInView:self.view];
    
    
    
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        //我的引导库
        if (buttonIndex == 0) {

            FirstListViewController *VC =[[FirstListViewController alloc]initWithNibName:@"FirstListViewController" bundle:nil];
            VC.delegate = self;
            VC.MemberchantID = self.MemberchantID;
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }
}



- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
//
//    
//    // 将图片存储在字典里
////    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 230,290)];
////    
////    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(230,290)];
//    
//    [self.Imagedic setValue:image forKey:@"logo"];
    
    
//    NSLog(@"%f,%f",imgV.image.size.width,imgV.image.size.height);
    
    // 计算图片显示的大小
    float height = image.size.width / 230.0f;
    UIGraphicsBeginImageContext(CGSizeMake(230,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 230, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
    
}





-(IBAction)BusinessLogoSaveBtn:(id)sender
{
    
    if ([self.bootPageImagesID isEqualToString:@"null"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择引导页图片"];
        return;
    }
    
    
    NSString * mes =[NSString stringWithFormat:@"确认修改【%@】引导页图片",self.MemberchantName];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:mes delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if ( buttonIndex == 1 ) {
        
        [self PutToserverLogo];
    }
}


-(void)PutToserverLogo
{

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId;NSString *key;
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    key = [CommonUtil getServerKey];
    
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           self.MemberchantID,@"merchantId",
                           self.bootPageImagesID,@"bootPageImagesID",
                           key,@"key",
                           nil];

    [SVProgressHUD showWithStatus:@"数据提交中"];
    [httpClient request:@"WxSiteSetBootPager.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
    
    
    
}



/**
 此方为必须实现的协议方法，用来传值
 */
- (void)changeValue:(NSString *)minURL second:(NSString *)valueID{
    // 改变UILabel的值
    
    NSString *path = minURL;
    self.bootPageImagesID = valueID;

    
    UIImageView*imv=[[UIImageView alloc]init];
    [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        UIImage *scaleImage = [self scaleImage:[CommonUtil scaleImage:image toSize:CGSizeMake(230, 290)] toScale:0.3];
        [self.ImageBtn setImage:scaleImage forState:UIControlStateNormal];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"资源不存在或已丢失!"];
        
    }];
    
    
}




@end
