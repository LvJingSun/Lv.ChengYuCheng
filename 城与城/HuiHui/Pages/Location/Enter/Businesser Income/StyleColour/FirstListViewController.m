//
//  FirstListViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-3-26.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FirstListViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "FirstPhotoViewController.h"
#import "FirstListCell.h"

@interface FirstListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table_key_list;

@end

@implementation FirstListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.fistphotoarray = [[NSMutableArray alloc]initWithCapacity:0];
        self.NewarrayID = [[NSMutableArray alloc]initWithCapacity:0];
        self.NewarrayImg = [[NSMutableArray alloc]initWithCapacity:0];
        self.ImageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.ImageDiction = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"我的引导库"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"新增" action:@selector(Photoadd)];
    
    self.table_key_list.hidden=YES;

    [self getphotolist];

    // Do any additional setup after loading the view from its nib.
}

- (void)leftClicked{
    
    [self goBack];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getphotolist
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
                           key,@"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"BootPagerList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];

            [self.fistphotoarray removeAllObjects];
            [self.NewarrayID removeAllObjects];
            [self.NewarrayImg removeAllObjects];
            
            self.fistphotoarray = [json valueForKey:@"BootPageImageList"];
            [self ConvertImageFromData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}


-(void)ConvertImageFromData
{
    
    self.table_key_list.hidden=YES;
    [SVProgressHUD showWithStatus:@"图片加载中……"];
    
    for (int i = 0; i < self.fistphotoarray.count; i ++) {
        
        NSDictionary *data = [self.fistphotoarray objectAtIndex:i];
        
        NSString *path = [data objectForKey:@"MinBgImg"];
        
        UIImageView*imv=[[UIImageView alloc]init];
        [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70,79)];
            [self.imageCache addImage:imgV.image andUrl:path];
            UIImage *scaleImage = [CommonUtil scaleImage:image toSize:CGSizeMake(70, 79)];
            
            
            [self.ImageDic setObject:scaleImage forKey:path];
            
            if (self.ImageDic.count==self.fistphotoarray.count)
            {
                [self getDic];
                
            }
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"资源不存在或已丢失!"];
            
        }];
    }
    
    
}

//重新整理图片；
- (void)getDic{
    
    for (int i = 0; i < self.fistphotoarray.count; i ++) {
        
        NSDictionary *dic = [self.fistphotoarray objectAtIndex:i];
  
        [self.NewarrayID addObject:[dic objectForKey:@"BootPageImagesID"]];
        [self.NewarrayImg addObject:[self.ImageDic objectForKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MinBgImg"]]]];
    
    }
    [SVProgressHUD dismiss];
    self.table_key_list.hidden=NO;
    [self.table_key_list reloadData];
}

-(void)add
{
    FirstPhotoViewController *VC =[[FirstPhotoViewController alloc]initWithNibName:@"FirstPhotoViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}



-(void)Photoadd
{
    
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"马上拍照",@"相册选取",nil];
    
    sheet.tag = 1;
    [sheet showInView:self.view];
    
    
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        //打开照相
        if (buttonIndex==0)
        {
            [self.ImageDiction removeAllObjects];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                //imagePicker.allowsImageEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex == 1) {
            [self.ImageDiction removeAllObjects];

            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
            
        }
        
    }
    else if (actionSheet.tag ==2)
    {
        
        if (buttonIndex ==0) {
            
            NSDictionary *dic = [self.fistphotoarray objectAtIndex:[self.ChoseBtn intValue]];
            
            [self.delegate changeValue:[dic objectForKey:@"MinBgImg"] second:[self.NewarrayID objectAtIndex:[self.ChoseBtn intValue]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else if (buttonIndex ==1)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除这张引导页图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alert show];

        }

    }
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
        if ( buttonIndex == 1 ) {
            
            [self delephoto:[self.NewarrayID objectAtIndex:[self.ChoseBtn intValue]]];

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
	[picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image=[[UIImage alloc]init];
    
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.image = savedImage;
    
    [self.ImageDiction setValue:[self getImageData:imgV] forKey:@"photo"];
    //上传图片
    if (self.ImageDiction.count!=0) {
        [self PUTphotoServer];
    }

    
}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

//-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
//    
////    // 将图片存储在字典里
//    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 230,290)];
//    
//    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(230,290)];
//    
//
//
////    NSLog(@"%f,%f",imgV.image.size.width,imgV.image.size.height);
//    
//    // 计算图片显示的大小
//    float height = image.size.width / 70.0f;
//    UIGraphicsBeginImageContext(CGSizeMake(70,image.size.height / height));
//    [image drawInRect:CGRectMake(0, 0, 70, image.size.height / height)];
//    
//    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    
//    return scaledImage;
//    
//}


-(void) PUTphotoServer
{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId;NSString *key;NSString *merchantId;

    merchantId =self.MemberchantID;
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  merchantId,@"merchantId",
                                  key,@"key",
                                  nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient multiRequest:@"BootPagerAdd.ashx" parameters:param files:self.ImageDiction success:^(NSJSONSerialization* json){
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            self.table_key_list.hidden = YES;
            [self getphotolist];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.NewarrayImg.count<=3) {
        return 1;
    }
    if (self.NewarrayImg.count%3==0) {
        return self.NewarrayImg.count/3;
    }else
    {
        return self.NewarrayImg.count/3+1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 88;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FirstListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"FirstListCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//cell 不被选择
    }
    if (self.NewarrayImg.count!=0) {

    int num = 0;
    for (int i=indexPath.row*3; i<(indexPath.row*3)+3; i++) {
        num +=1;
        if (i>=self.NewarrayImg.count) {
            
        }
        else{
            
            if (num ==1) {
                UIImage *scaleImage =[self.NewarrayImg objectAtIndex:i];
                [cell.Image1 setImage:scaleImage forState:UIControlStateNormal];
                 
                cell.Image1.tag = i;
                
                [cell.Image1 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];

            }
            else if (num ==2) {
                UIImage *scaleImage =[self.NewarrayImg objectAtIndex:i];
                [cell.Image2 setImage:scaleImage forState:UIControlStateNormal];
//                                cell.Image2.tag = [[NSString stringWithFormat:@"%@",[self.NewarrayID objectAtIndex:i]] intValue];
                cell.Image2.tag = i;
                [cell.Image2 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];

            }
            else if (num ==3) {
                UIImage *scaleImage =[self.NewarrayImg objectAtIndex:i];
                [cell.Image3 setImage:scaleImage forState:UIControlStateNormal];
                cell.Image3.tag = i;
                [cell.Image3 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            }

        }
    }
    
    }
    
    return cell;

}

//选择
- (void)choose:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    self.ChoseBtn = [NSString stringWithFormat:@"%d",btn.tag];
    
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择图片",@"删除图片",nil];
    
    sheet.tag = 2;
    [sheet showInView:self.view];

    
}


//删除
-(void) delephoto:(NSString*)ID
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *bootPageImagesID =ID;
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  bootPageImagesID,@"bootPageImagesID",
                                  key,@"key",
                                  nil];

    [SVProgressHUD showWithStatus:@"数据提交中"];
    [httpClient request:@"BootPagerDelete.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            NSDictionary *dic = [self.fistphotoarray objectAtIndex:[self.ChoseBtn intValue]];
                
            [self.fistphotoarray removeObject:dic];
            
            UIImage * image =[self.NewarrayImg objectAtIndex:[self.ChoseBtn intValue]];
            [self.NewarrayImg removeObject:image];
            
            NSString *ID = [self.NewarrayID objectAtIndex:[self.ChoseBtn intValue]];
            [self.NewarrayID removeObject:ID];
            
            [self.table_key_list reloadData];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
}




@end
