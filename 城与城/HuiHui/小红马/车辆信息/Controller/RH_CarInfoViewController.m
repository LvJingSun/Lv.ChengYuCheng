//
//  RH_CarInfoViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_CarInfoViewController.h"
#import "RedHorseHeader.h"
#import "RH_CarModel.h"
#import "CarInfoFrame.h"
#import "CarInfoCell.h"

#import "RH_CarBrandViewController.h"

#import "RH_CarBrandModel.h"
#import "RH_DatePickerView.h"


@interface RH_CarInfoViewController () <UITableViewDelegate,UITableViewDataSource,CarInfo_FieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {

    NSDate *currentDate;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) RH_DatePickerView *datepicker;

@end

@implementation RH_CarInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"车辆信息";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_CarInfoView)];
    
    [self allocWithTableview];
    
    self.array = [NSMutableArray array];
    
    NSMutableArray *mut = [NSMutableArray array];
    
    CarInfoFrame *frame = [[CarInfoFrame alloc] init];
    
    RH_CarModel *model = [[RH_CarModel alloc] init];
    
    frame.carModel = model;
    
    [mut addObject:frame];
    
    self.array = mut;

}

//车牌号输入框代理
- (void)PlateFieldChange:(UITextField *)field {
    
    for (CarInfoFrame *frame in self.array) {
        
        frame.carModel.carPlate = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

//购车款输入框代理
- (void)BuyMoneyFieldChange:(UITextField *)field {

    for (CarInfoFrame *frame in self.array) {
        
        frame.carModel.buyMoney = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

//发动机号输入框代理
- (void)EngineNumberFieldChange:(UITextField *)field {

    for (CarInfoFrame *frame in self.array) {
        
        frame.carModel.EngineNumber = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

//行驶里程输入框代理
- (void)MileageFieldChange:(UITextField *)field {

    for (CarInfoFrame *frame in self.array) {
        
        frame.carModel.Mileage = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

- (void)allocWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
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

    CarInfoCell *cell = [[CarInfoCell alloc] init];
    
    CarInfoFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    cell.ChooseBlock = ^{
        
        RH_CarBrandViewController *vc = [[RH_CarBrandViewController alloc] init];
        
        vc.popCar = ^(RH_CarBrandModel *mainBrand, RH_CarBrandModel *childCar) {
            
            frame.carModel.carImg = mainBrand.ImageSrc;
            
            frame.carModel.carModel = childCar.Name;
            
            frame.carModel.carBrandID = mainBrand.CheID;
            
            frame.carModel.carModelID = childCar.CheID;
            
            [tableView reloadData];
            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    cell.timeBlock = ^{
        
        RH_DatePickerView *chooseDateView = [[RH_DatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds datePickerMode:UIDatePickerModeDate lastDate:currentDate];
        
        [chooseDateView confirmDate:^(NSDate *date) {
            
            currentDate = date;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *currentDateString = [dateFormatter stringFromDate:date];
            
            frame.carModel.buyTime = currentDateString;
            
            [tableView reloadData];
            
        }];

        [chooseDateView showView];

    };
    
    cell.InvoiceBlock = ^{
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        
        [sheet showInView:self.view];
        
    };
    
    cell.SureBlock = ^{
        
        [self checkData];
        
    };
    
    return cell;
    
}

//检测数据是否填写完整
- (void)checkData {

    CarInfoFrame *frame = self.array[0];
    
    RH_CarModel *carmodel = frame.carModel;
    
    if ([self isNULLString:carmodel.carBrandID]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善信息再提交"];
        
    }else if ([self isNULLString:carmodel.carModelID]) {
    
        [SVProgressHUD showErrorWithStatus:@"请完善信息再提交"];
        
    }else if ([self isNULLString:carmodel.carPlate]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善车牌号信息"];
        
    }else if ([self isNULLString:carmodel.buyTime]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善购车时间信息"];
        
    }else if ([self isNULLString:carmodel.buyMoney]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善购车款信息"];
        
    }else if ([self isNULLString:carmodel.EngineNumber]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善发动机号信息"];
        
    }else if ([self isNULLString:carmodel.Mileage]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善里程信息"];
        
    }else if (carmodel.InvoiceImg == nil) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善发票信息"];
        
    }else {
    
        [self pushData];
        
    }
    
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
    
    for (CarInfoFrame *frame in self.array) {
        
        frame.carModel.InvoiceImg = image;
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableview reloadData];
    
}

//点击cancle实现的代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CarInfoFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)dismissRH_CarInfoView {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSData *)ImageForData:(UIImage *)image {
    
    return UIImageJPEGRepresentation(image, 0.3);
    
}

- (void)pushData {

    CarInfoFrame *frame = self.array[0];
    
    RH_CarModel *carmodel = frame.carModel;
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         carmodel.carPlate,@"CarNo",
                         carmodel.buyTime,@"BuyCarTime",
                         carmodel.buyMoney,@"BuyCarPayment",
                         carmodel.EngineNumber,@"VIN",
                         carmodel.Mileage,@"Mileage",
                         carmodel.carBrandID,@"BrandName",
                         carmodel.carModelID,@"BrandModel",
                         memberId,@"MemberId",
                         nil];
    
    NSDictionary *files = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self ImageForData:carmodel.InvoiceImg],@"CarInvoiceImg",
                           nil];
    
    [SVProgressHUD showWithStatus:@"信息提交中"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horsemultiRequest:@"MyCarInfoAdd.ashx" parameters:dic files:files success:^(NSJSONSerialization *json) {
        
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
