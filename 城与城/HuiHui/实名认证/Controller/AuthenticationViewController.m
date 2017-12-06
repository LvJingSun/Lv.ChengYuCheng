//
//  AuthenticationViewController.m
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "LJConst.h"
#import "AuthenticationModel.h"
#import "AuthenticationFrame.h"
#import "AuthenticationCell.h"
#import "SureIDInfoViewController.h"

@interface AuthenticationViewController () <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {

    NSString *picType; //1-正面 2-反面
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self  setTitle:@"实名认证"];
    
//    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self allocWithTableview];
    
    AuthenticationModel *model = [[AuthenticationModel alloc] init];
    
    AuthenticationFrame *frame = [[AuthenticationFrame alloc] init];
    
    frame.authenModel = model;
    
    NSMutableArray *temp = [NSMutableArray array];
    
    [temp addObject:frame];
    
    self.array = temp;
    
}

- (void)allocWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AuthenticationCell *cell = [[AuthenticationCell alloc] init];
    
    AuthenticationFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.faceImgBlock = ^{
        
        picType = @"1";
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        
        [sheet showInView:self.view];
        
    };
    
    cell.backImgBlock = ^{
        
        picType = @"2";
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        
        [sheet showInView:self.view];
        
    };
    
    cell.sureBlock = ^{
        
        [self checkData];
        
    };
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    AuthenticationFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)checkData {

    AuthenticationFrame *frame = self.array[0];
    
    if (frame.authenModel.faceImg == nil) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择身份证正面照片"];
        
    }else if (frame.authenModel.backImg == nil) {
    
        [SVProgressHUD showErrorWithStatus:@"请选择身份证反面照片"];
        
    }else {
    
        [self requestForFaceImg];
        
    }
    
}

- (void)requestForFaceImg {
    
    [SVProgressHUD showWithStatus:@"识别中..."];
    
    AuthenticationFrame *frame = self.array[0];

    NSData *imageData = UIImageJPEGRepresentation(frame.authenModel.faceImg, 0.3f);
    
    NSString *base64 = [imageData base64EncodedStringWithOptions:0];

    NSString *appcode = @"b0e7f112851b47c28ab708b9a251d32a";
    
    NSString *host = @"https://dm-51.data.aliyun.com";
    
    NSString *path = @"/rest/160601/ocr/ocr_idcard.json";
    
    NSString *method = @"POST";
    
    NSString *querys = @"";
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    
    NSString *body = [NSString stringWithFormat:@"{\"inputs\": [{\"image\": {\"dataType\": 50,\"dataValue\": \"%@\"},\"configure\": {\"dataType\": 50,\"dataValue\": \"{\\\"side\\\":\\\"face\\\"}\"}}]}",base64];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:1 timeoutInterval:5];
    
    request.HTTPMethod = method;
    
    [request addValue:[NSString stringWithFormat:@"APPCODE %@",appcode] forHTTPHeaderField:@"Authorization"];
    
    [request addValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        NSArray *outputs = dic[@"outputs"];
        
        NSDictionary *ocrDic = outputs[0];
        
        NSDictionary *outputValueDic = ocrDic[@"outputValue"];
        
        NSString *jsonResult = outputValueDic[@"dataValue"];
        
        NSDictionary *result = [self dictionaryWithJsonString:jsonResult];
        
        BOOL success = [[NSString stringWithFormat:@"%@",result[@"success"]] boolValue];
            
        if (success) {
            
            dispatch_group_t group = dispatch_group_create();
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                
                frame.authenModel.name = [NSString stringWithFormat:@"%@",result[@"name"]];
                
                frame.authenModel.nationality = [NSString stringWithFormat:@"%@",result[@"nationality"]];
                
                frame.authenModel.num = [NSString stringWithFormat:@"%@",result[@"num"]];
                
                frame.authenModel.sex = [NSString stringWithFormat:@"%@",result[@"sex"]];
                
                frame.authenModel.address = [NSString stringWithFormat:@"%@",result[@"address"]];
                
                frame.authenModel.birth = [NSString stringWithFormat:@"%@",result[@"birth"]];
                
                [self requestForBackImg];
                
            });
            
        }else {
            
            dispatch_group_t group = dispatch_group_create();
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showErrorWithStatus:@"请重新上传身份证正面照片"];
                
            });
            
        }
        
    }];
    
    [task resume];
    
}

- (void)requestForBackImg {

    AuthenticationFrame *frame = self.array[0];
    
    NSData *imageData = UIImageJPEGRepresentation(frame.authenModel.backImg, 0.3f);
    
    NSString *base64 = [imageData base64EncodedStringWithOptions:0];
    
    NSString *appcode = @"b0e7f112851b47c28ab708b9a251d32a";
    
    NSString *host = @"https://dm-51.data.aliyun.com";
    
    NSString *path = @"/rest/160601/ocr/ocr_idcard.json";
    
    NSString *method = @"POST";
    
    NSString *querys = @"";
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    
    NSString *body = [NSString stringWithFormat:@"{\"inputs\": [{\"image\": {\"dataType\": 50,\"dataValue\": \"%@\"},\"configure\": {\"dataType\": 50,\"dataValue\": \"{\\\"side\\\":\\\"back\\\"}\"}}]}",base64];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:1 timeoutInterval:5];
    
    request.HTTPMethod = method;
    
    [request addValue:[NSString stringWithFormat:@"APPCODE %@",appcode] forHTTPHeaderField:@"Authorization"];
    
    [request addValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *outputs = dic[@"outputs"];
        
        NSDictionary *ocrDic = outputs[0];
        
        NSDictionary *outputValueDic = ocrDic[@"outputValue"];
        
        NSString *jsonResult = outputValueDic[@"dataValue"];
        
        NSDictionary *result = [self dictionaryWithJsonString:jsonResult];
        
        [SVProgressHUD dismiss];
        
        BOOL success = [[NSString stringWithFormat:@"%@",result[@"success"]] boolValue];
        
        if (success) {
            
            dispatch_group_t group = dispatch_group_create();
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
                frame.authenModel.issue = [NSString stringWithFormat:@"%@",result[@"issue"]];
                
                frame.authenModel.start_date = [NSString stringWithFormat:@"%@",result[@"start_date"]];
                
                frame.authenModel.end_date = [NSString stringWithFormat:@"%@",result[@"end_date"]];
                
                SureIDInfoViewController *vc = [[SureIDInfoViewController alloc] init];
                
                vc.authModel = frame.authenModel;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            });
            
        }else {
            
            dispatch_group_t group = dispatch_group_create();
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showErrorWithStatus:@"请重新上传身份证反面照片"];
                
            });
            
        }
        
    }];
    
    [task resume];
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
        {
            [self PaiZhao];
        }
            break;
        case 1:
        {
            [self XiangCe];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)PaiZhao {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        [SVProgressHUD showErrorWithStatus:@"你的设备暂不支持拍照"];
        
    }
    
}

- (void)XiangCe {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        [SVProgressHUD showErrorWithStatus:@"你的设备暂不支持选取相册"];
        
    }
    
}

//拍照完成实现的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    for (AuthenticationFrame *frame in self.array) {
        
        if ([picType isEqualToString:@"1"]) {
            
            frame.authenModel.faceImg = image;
            
        }else if ([picType isEqualToString:@"2"]) {
        
            frame.authenModel.backImg = image;
            
        }
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableview reloadData];
    
}

//点击cancle实现的代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (void)leftClicked{
//    
//    [self goBack];
//    
//}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
