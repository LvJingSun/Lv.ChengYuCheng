//
//  ApplySubsidyViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ApplySubsidyViewController.h"
#import "OilHeadView.h"
#import "RedHorseHeader.h"
#import "RH_CarModel.h"

#import "ApplySubsidyModel.h"
#import "ApplyInPutFrame.h"
#import "ApplyInPutCell.h"
#import "RH_SwitchCarViewController.h"

@interface ApplySubsidyViewController () <UITableViewDelegate,UITableViewDataSource,Apply_fieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation ApplySubsidyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"申请";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popApplyInsuranceVC)];
    
    [self allocWithTableview];
    
    self.array = [NSMutableArray array];
    
    NSMutableArray *mut = [NSMutableArray array];
    
    ApplyInPutFrame *frame = [[ApplyInPutFrame alloc] init];
    
    ApplySubsidyModel *model = [[ApplySubsidyModel alloc] init];
    
    frame.applymodel = model;
    
    model.applyType = self.applyType;
    
    [mut addObject:frame];
    
    self.array = mut;
    
}

//初始化tableview
- (void)allocWithTableview {
    
    OilHeadView *headview = [[OilHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    __weak typeof(OilHeadView) *weakHeadview = headview;
    
    headview.switchBlock = ^{
        
        RH_SwitchCarViewController *vc = [[RH_SwitchCarViewController alloc] init];
        
        vc.popCar = ^(RH_CarModel *carModel) {
            
            self.DefaultCarID = carModel.CheID;
            
            self.DefaultCarModel = carModel.carModel;
            
            self.CarImg = carModel.carImg;
            
            [weakHeadview.iconImg setImageWithURL:[NSURL URLWithString:self.CarImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
            
            weakHeadview.carModel.text = self.DefaultCarModel;
            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [headview.iconImg setImageWithURL:[NSURL URLWithString:self.CarImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
    
    headview.carModel.text = self.DefaultCarModel;
    
    [self.view addSubview:headview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headview.frame), ScreenWidth, ScreenHeight - 64 - CGRectGetMaxY(headview.frame))];
    
    self.tableview = tableview;
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    
    vv.backgroundColor = RH_ViewBGColor;
    
    tableview.tableFooterView = vv;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ApplyInPutCell *cell = [[ApplyInPutCell alloc] init];
    
    ApplyInPutFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    cell.youfeiBlock = ^{
        
        frame.applymodel.applyType = @"4";
        
        [tableView reloadData];
        
    };
    
//    cell.baoxianBlock = ^{
//        
//        frame.applymodel.applyType = @"1";
//        
//        [tableView reloadData];
//        
//    };
    
    cell.baoyangBlock = ^{
        
        frame.applymodel.applyType = @"2";
        
        [tableView reloadData];
        
    };
    
//    cell.luntaiBlock = ^{
//        
//        frame.applymodel.applyType = @"5";
//        
//        [tableView reloadData];
//        
//    };
    
    cell.xiuliBlock = ^{
        
        frame.applymodel.applyType = @"3";
        
        [tableView reloadData];
        
    };
    
    cell.ChooseImgBlock = ^{
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        
        [sheet showInView:self.view];
        
    };
    
    cell.SureBlock = ^{
        
        [self checkForData];
        
    };
    
    return cell;
    
}

//检查填写的数据
- (void)checkForData {

    ApplyInPutFrame *frame = self.array[0];
    
    if ([self isNULLString:frame.applymodel.applyType]) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择补助项目"];
        
    }else if ([self isNULLString:frame.applymodel.count]) {
    
        [SVProgressHUD showErrorWithStatus:@"请填写补助金额"];
        
    }else if (frame.applymodel.InvoiceImg == nil) {
    
        [SVProgressHUD showErrorWithStatus:@"请上传发票"];
        
    }else {
    
        [self requestForPushData];
        
    }
    
}

- (NSData *)ImageForData:(UIImage *)image {
    
    return UIImageJPEGRepresentation(image, 0.3);
    
}

//提交申请请求
- (void)requestForPushData {
    
    ApplyInPutFrame *frame = self.array[0];

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"MemberId",
                         self.DefaultCarID,@"ID",
                         frame.applymodel.count,@"Account",
                         frame.applymodel.applyType,@"type",
                         @"",@"desc",
                         nil];
    
    NSDictionary *files = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self ImageForData:frame.applymodel.InvoiceImg],@"CarInvoiceImg",
                           nil];
    
    [SVProgressHUD showWithStatus:@"提交申请中"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horsemultiRequest:@"ApplySubsidy.ashx" parameters:dic files:files success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (BOOL)isNULLString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
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
    
    for (ApplyInPutFrame *frame in self.array) {
        
        frame.applymodel.InvoiceImg = image;
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableview reloadData];
    
}

//点击cancle实现的代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//补助金额填写代理
- (void)ApplyMoneyFieldChange:(UITextField *)field {

    for (ApplyInPutFrame *frame in self.array) {
        
        frame.applymodel.count = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ApplyInPutFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)popApplyInsuranceVC {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
