//
//  ManagementViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-5-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "ManagementViewController.h"
#import "ManageCollectionViewCell.h"

@interface ManagementViewController ()

@property (nonatomic,strong)NSMutableArray *ChepArray;

@end

@implementation ManagementViewController

@synthesize m_merchantShopId;

@synthesize ChepArray;

@synthesize m_seatId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        ChepArray = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.ChepArray addObject:@""];
//    [self.ChepArray addObject:@""];
//    [self.ChepArray addObject:@""];
//    [self.ChepArray addObject:@""];
//    [self.ChepArray addObject:@""];

    [self setTitle:@"座位包厢管理"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    //    ChePableview.hidden = YES;
    [ChePableview setDelegate:self];
    [ChePableview setDataSource:self];
    
    // 请求座位列表的数据
    [self seatListRequest];
    
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UICollectionView
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.ChepArray.count+1;
}
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Register nib file for the cell
    UINib *nib = [UINib nibWithNibName:@"ManageCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"ManageCollectionViewCell"];
    ManageCollectionViewCell *cell = [[ManageCollectionViewCell alloc]init];
    
    // Set up the reuse identifier
    cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ManageCollectionViewCell"
                                                     forIndexPath:indexPath];
    

    if (indexPath.row == self.ChepArray.count) {
        cell.deal_image.image = [UIImage imageNamed:@"addicon.png"];
        cell.deal_price.text = @"";

    }else
    {
        cell.deal_image.image = nil;
        
        if ( self.ChepArray.count != 0 ) {
            
            NSDictionary *dic = [self.ChepArray objectAtIndex:indexPath.row];
            
            cell.deal_price.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatName"]];
            
        }

    }
    
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WindowSizeWidth/4, 65);
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;{
    return 5;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0;
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}


//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == self.ChepArray.count ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"输入座位包厢名称"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        m_fieldText = [alert textFieldAtIndex:0];
        m_fieldText.delegate = self;

        alert.tag = 111;
        [alert show];
        
    }else{
        
        if ( self.ChepArray.count != 0 ) {
            
            NSDictionary *dic = [self.ChepArray objectAtIndex:indexPath.row];
            
            self.m_seatId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatId"]];
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatName"]]
                                                                    delegate:self
                                                           cancelButtonTitle:@"取消"
                                                      destructiveButtonTitle:nil
                                                           otherButtonTitles:@"删除",@"编辑", nil];
            
            actionSheet.tag = 12345;
            [actionSheet showInView:self.view];
        }
        
       
    }
    
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - EditSeatName
- (void)editSeatName:(NSString *)seatName{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"编辑座位包厢名称"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"修改", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *messageTextField = [alert textFieldAtIndex:0];
    messageTextField.text = seatName;
    
    m_fieldText = [alert textFieldAtIndex:0];
    m_fieldText.delegate = self;
    
    alert.tag = 22323;
    [alert show];
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if ([alertView cancelButtonIndex] != buttonIndex) {

        if ( alertView.tag == 111 ) {
            
            UITextField *messageTextField = [alertView textFieldAtIndex:0];

            if (messageTextField.text.length > 0){
                
                [self addSeatRequest:messageTextField.text];
                
            }else
            {
                [self showHint:@"座位包厢名称不能为空!"];
            }
            
            
            
        }else if ( alertView.tag == 1234 ){
            
            // 确定删除
            [self deleteSeatRequest];
            
        }else if ( alertView.tag == 22323 ){
            // 编辑
            UITextField *messageTextField = [alertView textFieldAtIndex:0];
            
            if (messageTextField.text.length > 0){
                
                [self editSeatRequest:messageTextField.text];
                
            }else
            {
                [self showHint:@"座位包厢名称不能为空!"];
            }
            
        }
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == m_fieldText ) {
        
        [self hiddenNumPadDone:nil];
        
    }
    
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if ( actionSheet.tag == 12345) {
        
        if ( buttonIndex == 0 ) {
            
            // 删除座位
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"您确定删除该座位包厢?"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
            alert.tag = 1234;
            [alert show];
            
        }else if ( buttonIndex == 1){
            
            // 编辑座位
            [self editSeatName:actionSheet.title];
            
            
            
        }
        
    }


}

#pragma mark - NetWork
- (void)seatListRequest{
    
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
                           [NSString stringWithFormat:@"%@",self.m_merchantShopId],@"merchantShopId",nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"SeatList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.ChepArray = (NSMutableArray *)[json valueForKey:@"SeatList"];
        
            
            // 刷新列表
            [ChePableview reloadData];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
}

- (void)addSeatRequest:(NSString *)seatName{
    
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
                           [NSString stringWithFormat:@"%@",self.m_merchantShopId],@"merchantShopId",
                           [NSString stringWithFormat:@"%@",seatName],@"seatName",nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"AddSeat.ashx" parameters:param success:^(NSJSONSerialization* json) {
       
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 请求数据刷新页面
            [self seatListRequest];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

- (void)deleteSeatRequest{
    
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
                           [NSString stringWithFormat:@"%@",self.m_seatId],@"seatId",nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"DeleteSeat.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 请求数据刷新页面
            [self seatListRequest];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
 
}

- (void)editSeatRequest:(NSString *)seatName{
    
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
                           [NSString stringWithFormat:@"%@",self.m_seatId],@"seatId",
                           [NSString stringWithFormat:@"%@",seatName],@"seatName",
                           [NSString stringWithFormat:@"%@",self.m_merchantShopId],@"merchantShopId",nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"EditSeat.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 请求数据刷新页面
            [self seatListRequest];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


@end
