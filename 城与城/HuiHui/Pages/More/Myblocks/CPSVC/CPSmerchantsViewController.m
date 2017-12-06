//
//  CPSmerchantsViewController.m
//  HuiHui
//
//  Created by fenghq on 15/9/22.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CPSmerchantsViewController.h"
#import "CPSTakeOrderTableViewCell.h"
#import "HCSStarRatingView.h"
#import "LSPaoMaView.h"
#import "CPSMFeedbackViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface CPSmerchantsViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    IBOutlet UITableView *SM_tableview;
    NSJSONSerialization *GetMerchantShopInfodic;
}
// 存放请求数据的shopId
@property (nonatomic, strong) NSString                      *m_shopId;

@end

@implementation CPSmerchantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SM_tableview.hidden = YES;
    [self infoRequestGetMerchantShopInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//上个界面传过来传赋值
- (void)setXBParamdic:(NSMutableDictionary *)XBParamdic
{
    _XBParamdic = XBParamdic;
    NSLog(@"%@",_XBParamdic);
    NSDictionary *dic = [[XBParamdic objectForKey:@"m_shopList"] objectAtIndex:0];
    self.m_shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = nil;
    if (indexPath.section ==0) {
       cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
    }else
    {
        cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
    
}
- (UITableViewCell *)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"CPSTakeOrderTableViewCell2";
    CPSTakeOrderTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CPSTakeOrderTableViewCell" owner:self options:nil];
        cell = (CPSTakeOrderTableViewCell2 *)[nib objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.value = [[GetMerchantShopInfodic valueForKey:@"Score"] floatValue];
    starRatingView.userInteractionEnabled = NO;
    starRatingView.tintColor = RGBACKTAB;
    [cell.startView addSubview:starRatingView];
    
    if (!GetMerchantShopInfodic) {
        cell.MerchantShopName.text =@"加载中…";
    }else{
    cell.MerchantShopName.text =[GetMerchantShopInfodic valueForKey:@"MerchantShopName"];
    }
    [cell setMactLogImagePath:[GetMerchantShopInfodic valueForKey:@"Logo"]];
    cell.Score.text =[NSString stringWithFormat:@"%.1f",[[GetMerchantShopInfodic valueForKey:@"Score"] floatValue]];
    cell.MerchantShopName.text =[GetMerchantShopInfodic valueForKey:@"MerchantShopName"];
    cell.SalesQsPricePsPrice.text =[NSString stringWithFormat:@"销量%@|%@元起送|配送费%@元",[GetMerchantShopInfodic valueForKey:@"Sales"],[GetMerchantShopInfodic valueForKey:@"QsPrice"],[GetMerchantShopInfodic valueForKey:@"PsPrice"]];
    
    
    NSString *IsZCWaiMai=[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCWaiMai"]];
    NSString *ModelType=[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"ModelType"]];
    
    if ([IsZCWaiMai isEqualToString:@"1"]) {
        //餐饮支持外卖的模式
        if ([ModelType isEqualToString:@"0"]) {
            cell.SalesQsPricePsPrice.text =[NSString stringWithFormat:@"销量%@|%@元起送|配送费%@元",[GetMerchantShopInfodic valueForKey:@"Sales"],[GetMerchantShopInfodic valueForKey:@"QsPrice"],[GetMerchantShopInfodic valueForKey:@"PsPrice"]];
        }else if ([ModelType isEqualToString:@"1"]){
            
        }else if ([ModelType isEqualToString:@"2"]){
            cell.SalesQsPricePsPrice.text =[NSString stringWithFormat:@"销量%@|配送费%@元",[GetMerchantShopInfodic valueForKey:@"Sales"],[GetMerchantShopInfodic valueForKey:@"PsPrice"]];
        }
        
    }else{
        cell.SalesQsPricePsPrice.text =[NSString stringWithFormat:@"销量%@",[GetMerchantShopInfodic valueForKey:@"Sales"]];
    }
    cell.Address.text =[GetMerchantShopInfodic valueForKey:@"Address"];
    [cell.phone addTarget:self action:@selector(callClicked) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"Distance"]] isEqualToString:@"<null>"]) {
        return cell;
    }

    CGFloat Distance =[[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"Distance"]] floatValue];
    if (Distance>1) {
        cell.Distance.text = [NSString stringWithFormat:@"%.1fkm",[[GetMerchantShopInfodic valueForKey:@"Distance"] floatValue]];
    }else{
        Distance = Distance*1000;
        cell.Distance.text = [NSString stringWithFormat:@"%.0f米",[[GetMerchantShopInfodic valueForKey:@"Distance"] floatValue]];
    }

    
    return cell;
    
}
- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"CPSTakeOrderTableViewCell3";
    CPSTakeOrderTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CPSTakeOrderTableViewCell" owner:self options:nil];
        cell = (CPSTakeOrderTableViewCell3 *)[nib objectAtIndex:3];
        if (indexPath.section==1) {
            if (![cell.contentView viewWithTag:9999]) {
                LSPaoMaView* paomav = [[LSPaoMaView alloc] initWithFrame:CGRectMake(35, 10, self.view.bounds.size.width-35, 20) title:[GetMerchantShopInfodic valueForKey:@"Notice"]];
                paomav.tag =9999;
                [cell.contentView addSubview:paomav];
            }
        }
    }
    if (indexPath.section == 5||indexPath.section ==7) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageCPSIMV.image = nil;
    switch (indexPath.section) {
        case 1:
            cell.textCPSLabel.text = @"";
            cell.imageCPSIMV.image = [UIImage imageNamed:@"ddt_takeout_store_notice_icon"];
            
            break;
        case 2:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCFirstBuy"]]isEqualToString:@"1"]) {
                cell.textCPSLabel.text = [NSString stringWithFormat:@"首次购买减￥%@",[GetMerchantShopInfodic valueForKey:@"FirstBuyYHPrice"]];
                cell.hidden =NO;
            }else{
            cell.textCPSLabel.text = @"不支持首次购买活动";
            cell.hidden =YES;
            }

            cell.imageCPSIMV.image = [UIImage imageNamed:@"ddt_takeout_tag_icon"];
            break;
        case 3:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCHowMuchLess"]]isEqualToString:@"1"]) {
                cell.textCPSLabel.text = [NSString stringWithFormat:@"满%@减%@",[GetMerchantShopInfodic valueForKey:@"MoreThanPrice"],[GetMerchantShopInfodic valueForKey:@"MinuesPrice"]];
                cell.hidden =NO;

            }else{
                cell.textCPSLabel.text = @"不支持满立减活动";
                cell.hidden =YES;
            }
            
            cell.imageCPSIMV.image = [UIImage imageNamed:@"ddt_takeout_tag_icon"];
            break;
        case 4:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCMLZ"]]isEqualToString:@"1"]) {
                cell.textCPSLabel.text = [NSString stringWithFormat:@"满%@赠%@",[GetMerchantShopInfodic valueForKey:@"ManPrice"],[GetMerchantShopInfodic valueForKey:@"ZengPin"]];
                cell.hidden =NO;
            }else{
                cell.textCPSLabel.text = @"不支持满立赠活动";
                cell.hidden =YES;
            }
            
            cell.imageCPSIMV.image = [UIImage imageNamed:@"ddt_takeout_tag_icon"];
            break;
        case 5:
            cell.textCPSLabel.text = @"商家证照";
            cell.textCPSLabel.frame = CGRectMake(8, cell.textCPSLabel.frame.origin.y, cell.textCPSLabel.frame.size.width, cell.textCPSLabel.frame.size.height);
            break;
        case 6:
            cell.textCPSLabel.text = [NSString stringWithFormat:@"营业时间：%@",[GetMerchantShopInfodic valueForKey:@"OpeningHours"]];
            cell.textCPSLabel.frame = CGRectMake(8, cell.textCPSLabel.frame.origin.y, cell.textCPSLabel.frame.size.width, cell.textCPSLabel.frame.size.height);

            break;
        case 7:
            cell.textCPSLabel.text = @"意见反馈";
            cell.textCPSLabel.frame = CGRectMake(8, cell.textCPSLabel.frame.origin.y, cell.textCPSLabel.frame.size.width, cell.textCPSLabel.frame.size.height);

            break;
        default:
            break;
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    switch (section) {
        case 2:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCFirstBuy"]] isEqualToString:@"1"]) {
            }else{
                return 0.001f;
            }
            break;
        case 3:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCHowMuchLess"]] isEqualToString:@"1"]) {
            }else{
                return 0.001f;
            }
            break;
        case 4:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCMLZ"]] isEqualToString:@"1"]) {
            }else{
                return 0.001f;
            }
            break;
        default:
            break;
    }
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (!indexPath.section) {
        return 118.f;
    }
    switch (indexPath.section) {
        case 2:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCFirstBuy"]] isEqualToString:@"1"]) {
                return 40.f;
            }else{
                return 0;
            }
            break;
        case 3:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCHowMuchLess"]] isEqualToString:@"1"]) {
                return 40.f;
            }else{
                return 0;
            }
            break;
        case 4:
            if ([[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"IsZCMLZ"]] isEqualToString:@"1"]) {
                return 40.f;
            }else{
                return 0;
            }
            break;
        default:
            break;
    }
    return 40.f;
}


#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 5:
            [self changeBigImageV];
            break;
        case 7:
            [self PushCPSMFeedbackVC];
            break;
        default:
            break;
    }
    
}

- (void)changeBigImageV
{
    NSMutableArray *photos=[[NSMutableArray alloc]initWithCapacity:0];
    // 1.封装图片数据
        NSString *path = [NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"BusinessLicensePhoto"]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:path]; // 图片路径
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        imageV.image = [UIImage imageNamed:@"invite_reg_no_photo.png"];
        photo.srcImageView = imageV;
        [photos addObject:photo];
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}

//进入意见反馈
- (void)PushCPSMFeedbackVC{
    
    CPSMFeedbackViewController *VC = [[CPSMFeedbackViewController alloc]initWithNibName:@"CPSMFeedbackViewController" bundle:nil];
    VC.m_shopId = self.m_shopId;
    [self.navigationController pushViewController:VC animated:YES];

}


- (void)infoRequestGetMerchantShopInfo{
    
    // 经纬度 ======
    NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
    NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           self.m_shopId,@"MerchantShopID",
                           [NSString stringWithFormat:@"%f",[lontiduteString floatValue]],@"MapX",
                           [NSString stringWithFormat:@"%f",[latitudeString floatValue]],@"MapY",
                           nil];
    NSLog(@"params = %@",param);
    
    [httpClient request:@"GetMerchantShopInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            GetMerchantShopInfodic = json;
            NSLog(@"%@",json);
            SM_tableview.delegate = self;
            SM_tableview.dataSource = self;
            SM_tableview.hidden = NO;
            [SM_tableview reloadData];
        
        }else{
        [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)callClicked{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:[NSString stringWithFormat:@"%@",[GetMerchantShopInfodic valueForKey:@"Tel"]],nil];
    sheet.tag = 10001;
    [sheet showInView:self.navigationController.view.window];
    
}

#pragma mark - UIActionSheetDelegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        if (buttonIndex==0)
        {
            // 判断设备是否支持
            if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                message:@"该设备暂不支持电话功能"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles: nil];
                [alert show];
                
            }else{
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[GetMerchantShopInfodic valueForKey:@"Tel"]]]];
                
            }
            
        }
        
    }
    
}

@end
