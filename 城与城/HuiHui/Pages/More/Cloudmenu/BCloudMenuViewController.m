//
//  BCloudMenuViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-5-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BCloudMenuViewController.h"
#import "BCloundMenuTableViewCell.h"
#import "AddBCMenuViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MenuSettingViewController.h"

@interface BCloudMenuViewController ()

@property(nonatomic,strong) NSMutableArray * LeftArray;

@end

@implementation BCloudMenuViewController
@synthesize BCMLeftTableview;
@synthesize BCMRightTableview;
@synthesize m_menuClassId;

@synthesize BCMLeftArray;
@synthesize BCMRightArray;

@synthesize m_index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        BCMLeftArray = [[NSMutableArray alloc]initWithCapacity:0];
        BCMRightArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的门店云菜单"];
   
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 右上角添加设置的按钮
    [self setRightButtonWithTitle:@"设置" action:@selector(settingClicked)];
    
    SelectLeft = 0;
    SelectRight = 0;
    
    m_index = 0;
    
    self.m_menuClassId = @"";

    [self AllocLeftTB];
    [self AllocRithTB];
    
    [self CloudMenuClassList];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(editordel:)];
    [BCMLeftTableview addGestureRecognizer:longPressGr];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 判断自定义菜单页面的显示
    [CommonUtil addValue:@"0" andKey:@"Custom_menu_Key"];
    
    NSString *advertsKey = [CommonUtil getValueByKey:MenuListKey];
    
    if ( [advertsKey isEqualToString:@"1"] ) {
        
        [CommonUtil addValue:@"0" andKey:MenuListKey];
        
        // 请求数据进行刷新页面
        [self CloudMenuList:self.m_menuClassId];
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)settingClicked{
    
    // 进入设置的页面
    MenuSettingViewController *VC = [[MenuSettingViewController alloc]initWithNibName:@"MenuSettingViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    

}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AllocLeftTB
{
    [BCMLeftTableview initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section)
     {
         return self.BCMLeftArray.count +1;
         
     } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         if (indexPath.row ==self.BCMLeftArray.count) {
             
             BCloundMenuTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"BCloundMenuTableViewCell1Identifier"];
             
             if (!cell)
             {
                 cell=[[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuTableViewCell" owner:self options:nil]objectAtIndex:1];
                 [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
             }
             
             [cell.m_Btn addTarget:self action:@selector(ADDleftmenu) forControlEvents:UIControlEventTouchUpInside];
             
             return cell;
             
         }else{
             
             BCloundMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BCloundMenuTableViewCellIdentifier"];
             
             if (!cell)
             {
                 cell=[[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuTableViewCell" owner:self options:nil]objectAtIndex:0];
                 [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

             }
             
             NSDictionary *dic = [self.BCMLeftArray objectAtIndex:indexPath.row];
             
             cell.m_labeltext.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuClassName"]];
             if (SelectLeft == indexPath.row) {
                 cell.m_labeltext.textColor = RGBA(239, 154, 85, 1);
             }else{
                 cell.m_labeltext.textColor = [UIColor blackColor];
             }
             
             return cell;
             
         }
         
         return nil;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         if (indexPath.row !=self.BCMLeftArray.count) {
             SelectLeft = indexPath.row;
             NSDictionary *dic = [self.BCMLeftArray objectAtIndex:indexPath.row];
             NSString *cloudMenuClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
             
             // 将类别的名称保存起来用于自定义菜单的时候显示标题
             [CommonUtil addValue: [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuClassName"]] andKey:MENUCLASSNAME];
             
             self.m_menuClassId = [NSString stringWithFormat:@"%@",cloudMenuClassId];
             
             [self.BCMLeftTableview reloadData];
             [self CloudMenuList:cloudMenuClassId];
         }
         
     }];
    
    [self.BCMLeftTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.BCMLeftTableview.layer setBorderWidth:0];
}

- (void)AllocRithTB{

    [self.BCMRightTableview initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section)
     {
         return self.BCMRightArray.count +1;
         
     } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView,NSIndexPath *indexPath)
     {

         if (indexPath.row == self.BCMRightArray.count) {
             
             BCloundMenuTableViewCell3 *cell=[tableView dequeueReusableCellWithIdentifier:@"BCloundMenuTableViewCell3Identifier"];
             
             if (!cell)
             {
                 cell=[[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuTableViewCell" owner:self options:nil]objectAtIndex:3];
                 [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

             }
             
             [cell.m_Btn addTarget:self action:@selector(ADDrightmenu) forControlEvents:UIControlEventTouchUpInside];

             return cell;
             
         }else{
             
             BCloundMenuTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"BCloundMenuTableViewCell2Identifier"];
             
             if ( !cell )
             {
                 cell = [[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuTableViewCell" owner:self options:nil]objectAtIndex:2];
                 
                 [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

             }
             
             if ( self.BCMRightArray.count != 0 ) {
                 
                 NSDictionary *dic = [self.BCMRightArray objectAtIndex:indexPath.row];
                 
                 cell.m_labelname.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
                 cell.m_labelpice.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"MenuPriceCC"]];
                 cell.m_labeloldpice.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"MenuPrice"]];
                 
//                 [cell.m_numImgV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuImage"]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                 
                 [cell setImagePath:[dic objectForKey:@"MenuImage"]];
                 
             }
            
             
             return cell;
             
         }
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         self.m_index = indexPath.row;
         
         if ( indexPath.row < self.BCMRightArray.count ) {
             
             UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"提示"
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"删除",@"编辑",/*@"置顶",*/ nil];
             
             actionSheet.tag = 10212;
             [actionSheet showInView:self.view];
             
         }

        
         
     }];
    
    [self.BCMRightTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.BCMRightTableview.layer setBorderWidth:0];
    
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if ([alertView cancelButtonIndex] != buttonIndex) {
       
        if (alertView.tag ==111) {
            
            UITextField *messageTextField = [alertView textFieldAtIndex:0];
            
            if (messageTextField.text.length > 0){
                
                [self AddCloudMenuClass:messageTextField.text];
                
            }else
            {
                [self showHint:@"类别不能为空!"];
            }
            
        }else if (alertView.tag ==112){
           
            UITextField *messageTextField = [alertView textFieldAtIndex:0];
            
            if (messageTextField.text.length > 0){
                
                [self EditCloudMenuClass:CloudMenuClass andCloudMenuClass:messageTextField.text];
                
                CloudMenuClass = @"";
                
            }else
            {
                [self showHint:@"类别不能为空!"];
            }
            
            
        }else if ( alertView.tag == 12321 ) {
            
            // 删除菜单
            [self deleteMenuRequest];
            
        }
        
    }
    
}


- (void)ADDleftmenu{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"输入类别名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
   
    m_fieldText = [alert textFieldAtIndex:0];
    m_fieldText.delegate = self;
    
    alert.tag =111;
    [alert show];
    
}

- (void)editleftmenu:(NSString *)classname{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"编辑类别名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *messageTextField = [alert textFieldAtIndex:0];
    messageTextField.text =classname;
    
    m_fieldText = [alert textFieldAtIndex:0];
    m_fieldText.delegate = self;
    
    alert.tag =112;
    [alert show];
    
}

- (void)ADDrightmenu{
    
    if ( self.m_menuClassId.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请先选择菜单类别"];
        
        return;
        
    }
    
    // 进入菜单新增的页面
    AddBCMenuViewController *VC = [[AddBCMenuViewController alloc]initWithNibName:@"AddBCMenuViewController" bundle:nil];
    VC.m_menuClassId = [NSString stringWithFormat:@"%@",self.m_menuClassId];
    VC.m_type = @"1";
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == m_fieldText ) {
        
        [self hiddenNumPadDone:nil];
        
    }
    
}

//云菜单类别列表
-(void)CloudMenuClassList{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
//    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           /*merchantId,@"merchantId",*/nil];
    [httpClient request:@"CloudMenuClassList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            self.BCMLeftArray = (NSMutableArray *)[json valueForKey:@"MenuClassList"];
          
            if ( self.BCMLeftArray.count != 0 ) {
                
                if ( SelectLeft >= self.BCMLeftArray.count ) {
                    
                    SelectLeft = self.BCMLeftArray.count - 1;
                    
                }
                
                NSDictionary *dic = [self.BCMLeftArray objectAtIndex:SelectLeft];
                NSString *cloudMenuClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
                
                self.m_menuClassId = [NSString stringWithFormat:@"%@",cloudMenuClassId];
                
                // 将类别的名称保存起来用于自定义菜单的时候显示标题
                [CommonUtil addValue: [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuClassName"]] andKey:MENUCLASSNAME];
                
                [self CloudMenuList:cloudMenuClassId];
                
            }
            
            
            
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
        [BCMLeftTableview reloadData];


    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [BCMLeftTableview reloadData];
        
    }];
    
}

//删除云菜单类别
- (void)DeleteCloudMenuClass:(NSString *)cloudMenuClassID{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           cloudMenuClassID,@"cloudMenuClassID",
                           merchantId,@"merchantId",nil];
    [httpClient request:@"DeleteCloudMenuClass.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            
            if ( SelectLeft < self.BCMLeftArray.count ) {
                
                NSDictionary *dic = [self.BCMLeftArray objectAtIndex:SelectLeft];
                NSString *ClassID = [dic objectForKey:@"CloudMenuClassID"];
                
                if ([ClassID isEqualToString:cloudMenuClassID]) {
                    
                    SelectLeft = 0;
                    
                }else{
                    
                    
                }
            }else{
                
                // 如果超过的话则直接先赋值为0
                SelectLeft = 0;
                
            }
            
            [self CloudMenuClassList];
            
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}
//编辑云菜单类别
-(void)EditCloudMenuClass:(NSString *)cloudMenuClassID andCloudMenuClass:(NSString *)MenuClass{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           cloudMenuClassID,@"cloudMenuClassID",
                           MenuClass,@"menuClassName",
                           merchantId,@"merchantId",nil];
    [httpClient request:@"EditCloudMenuClass.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            [self CloudMenuClassList];
            
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}
//添加云菜单类别
-(void)AddCloudMenuClass:(NSString*)menuClassName{

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           menuClassName,@"menuClassName",
                           merchantId,@"merchantId",nil];
    [httpClient request:@"AddCloudMenuClass.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];

            [self CloudMenuClassList];
            
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
}

-(void)editordel:(UITapGestureRecognizer *)tap
{
    if(tap.state != UIGestureRecognizerStateBegan){
        return;
    }
    
    CGPoint point = [tap locationInView:BCMLeftTableview];
    NSIndexPath * indexPath = [BCMLeftTableview indexPathForRowAtPoint:point];
    
    m_zdIndex = indexPath.row;
    
    if(indexPath == nil ||indexPath.row ==self.BCMLeftArray.count) return ;

    NSDictionary *dic = [self.BCMLeftArray objectAtIndex:indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuClassName"]];
    CloudMenuClass =[NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:title
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"删除",@"编辑",@"置顶", nil];
    
    actionSheet.tag = 1001;
    [actionSheet showInView:self.view];
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ( actionSheet.tag == 1001) {
        
        if ( buttonIndex == 0 ) {
            
            [self DeleteCloudMenuClass:CloudMenuClass];
            CloudMenuClass = @"";
            
        }else if ( buttonIndex == 1){
            
            [self editleftmenu:actionSheet.title];
            
        }else{
            
            // 设置类别置顶
//            [self showHint:@"设置类别置顶"];
            
            NSDictionary *dic = [self.BCMLeftArray objectAtIndex:m_zdIndex];
            [self.BCMLeftArray removeObjectAtIndex:m_zdIndex];
            [self.BCMLeftArray insertObject:dic atIndex:0];
            
            NSString *cloudMenuClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
            SelectLeft = 0;
            
            [self.BCMLeftTableview reloadData];
            [self CloudMenuList:cloudMenuClassId];
            
        }
        
    }else if ( actionSheet.tag == 10212 ){
        
        if ( buttonIndex == 0 ) {
            // 删除菜单
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"您确定删除该菜单?"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];

            alert.tag = 12321;
            [alert show];
            
            
            
        }else if ( buttonIndex == 1){
            // 编辑菜单 进入菜单编辑的页面
          
            NSMutableDictionary *dic = [self.BCMRightArray objectAtIndex:self.m_index];
            
            AddBCMenuViewController *VC = [[AddBCMenuViewController alloc]initWithNibName:@"AddBCMenuViewController" bundle:nil];
            VC.m_menuClassId = [NSString stringWithFormat:@"%@",self.m_menuClassId];
            VC.m_dic = dic;
            VC.m_type = @"2";
            VC.shijian = dic[@"ShiChang"];
            VC.isFuWu = dic[@"IsFuWuXiangMu"];
            VC.biliArray = dic[@"YongJinigLevelList"];
            
            [self.navigationController pushViewController:VC animated:YES];
    

        }else{
            
            // 设置菜单置顶
//            [self showHint:@"设置菜单置顶"];
            
        }
        
        
    }
}


//云菜单子类别列表
-(void)CloudMenuList:(NSString *)cloudMenuClassId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           cloudMenuClassId,@"cloudMenuClassId",nil];
    
    
    
    [httpClient request:@"CloudMenuList_3.ashx" parameters:param success:^(NSJSONSerialization* json) {
       
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];

        if (success) {
            
            if ( self.BCMRightArray.count != 0 ) {
                
                [self.BCMRightArray removeAllObjects];
                
            }
            
            self.BCMRightArray = (NSMutableArray *)[json valueForKey:@"MenuList"];
            
            [BCMRightTableview reloadData];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [BCMRightTableview reloadData];
        
    }];
    
}

// 删除类别下面的子菜单
- (void)deleteMenuRequest{
    
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    
    NSDictionary *dic = [self.BCMRightArray objectAtIndex:self.m_index];

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuID"]],@"cloudMenuId",nil];
    
    [httpClient request:@"DeleteCloudMenu.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            [self CloudMenuList:self.m_menuClassId];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        [BCMRightTableview reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [BCMRightTableview reloadData];
        
    }];

    
    
    
}


@end
