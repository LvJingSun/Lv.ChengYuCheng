//
//  NewCommentViewController.m
//  HuiHui
//
//  Created by mac on 14-9-1.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "NewCommentViewController.h"

#import "NewCommentwCell.h"

#import "CommonUtil.h"

#import "MorecommentViewController.h"





@interface NewCommentViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

// 查看更多的消息按钮触发的事件
- (IBAction)CheckOutMore:(id)sender;


@end

@implementation NewCommentViewController

@synthesize m_commentArray;

@synthesize m_moreArray;

@synthesize m_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_commentArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_moreArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"新评论"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"清空" action:@selector(cleanArray)];
    
    // 判断文件路径里面是否包含这个文件
    NSFileManager *fm = [NSFileManager defaultManager];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID];
    
    NSString *finalPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_DynCommentList.plist",userId]];
    
    // 如果存在则从文件中读取数据
    if ( [fm fileExistsAtPath:finalPath] ) {
        
        self.m_moreArray = [NSMutableArray arrayWithContentsOfFile:finalPath];
        
    }
    
    // 根据plist里面的数据判断是否显示tableView的footerView
    if ( self.m_moreArray.count != 0 ) {
        
        self.m_tableView.tableFooterView = self.m_footerView;
        
    }else{
        
        self.m_tableView.tableFooterView = nil;
        
    }
    
    // 请求新评论的接口
    [self newCommentRequest];
    
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
    
    // 标记下如果从这个页面返回的话则进入动态列表页面时要刷新下数据看看是否有新评论
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_commentArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"NewCommentwCellIdentifier";
    
    NewCommentwCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewCommentwCell" owner:self options:nil];
        
        cell = (NewCommentwCell *)[nib objectAtIndex:0];
        
    }
    
    // 赋值
    if ( self.m_commentArray.count != 0 ) {
        
        NSDictionary *dic = [self.m_commentArray objectAtIndex:indexPath.row];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ToNickName"]];
        
        cell.m_commentLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DynContents"]];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateTime"]];
        
        // 设置头像的图片
        NSString *path = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoMidUrl"]];
        
        [cell setImageView:path];
        
        NSString *imageString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DynBigImgUrl"]];
        
        
        if ( imageString.length != 0 ) {
            // 如果图片有值的话，则进行图片赋值，否则的话显示文字内容
            cell.m_contentLabel.hidden = YES;
            
            cell.m_contentImagV.hidden = NO;
            
            [cell setImageViewBigPath:imageString];
            
        }else{
            
            cell.m_contentLabel.hidden = NO;
            
            cell.m_contentImagV.hidden = YES;
            
            cell.m_contentLabel.backgroundColor = [UIColor lightGrayColor];
            
            cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Contents"]];
        }
        
        // 设置图片的圆角
        cell.m_imageView.layer.masksToBounds = YES;
        cell.m_imageView.layer.cornerRadius = 5.0;
    }
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 72.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableDictionary *dic = [self.m_commentArray objectAtIndex:indexPath.row];
    
    NSString *dymaicId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DynamicID"]];
    
    // 根据动态的Id进行请求数据，用于传递于下一个页面
    [self dymaicRequestWithDymaicId:dymaicId];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

#pragma mark - NetWork
// 根据动态的Id请求数据用于传值于下一个页面
- (void)dymaicRequestWithDymaicId:(NSString *)aDymaicId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",aDymaicId],@"dynamicID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"DynamicComment.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            //            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            NSMutableDictionary *dic = [json valueForKey:@"DynModel"];
            
            // 进入具体的评论列表
            MorecommentViewController * VC = [[MorecommentViewController alloc]initWithNibName:@"MorecommentViewController" bundle:nil];
            VC.m_MoreDIC  = dic;
            [self.navigationController pushViewController:VC animated:YES];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

// 新评论请求数据
- (void)newCommentRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"DynamicCommentsList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            //            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            if ( self.m_commentArray.count != 0) {
                [self.m_commentArray removeAllObjects];
            }
      
            self.m_commentArray = [json valueForKey:@"DynCommentList"];
            [self.m_tableView reloadData];
            if ( self.m_commentArray.count != 0 ) {
                
                // 添加到数组里并且存储到plist文件里
                [self.m_array addObjectsFromArray:self.m_commentArray];
                if ( self.m_moreArray.count != 0 ) {
                    [self.m_array addObjectsFromArray:self.m_moreArray];
                }
                
                // 将类别的数据存储到plist里面用于网络不好时从plist里面读取
                NSFileManager *fm = [NSFileManager defaultManager];
                
//                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

                NSString *documentDirectory = [paths objectAtIndex:0];
                
                NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID];
                
                NSString *finalPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_DynCommentList.plist",userId]];
                
                //开始创建文件-文件中不存在此路径的文件的话则取创建文件
                if ( ![fm fileExistsAtPath:finalPath] ) {
                    
                    [fm createFileAtPath:finalPath contents:nil attributes:nil];
                    
                }
                
                // 把字典中的数据写入到文件中
                [self.m_array writeToFile:finalPath atomically:YES];
                
            }
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (IBAction)CheckOutMore:(id)sender {
    
    if ( self.m_commentArray.count != 0 ) {
        
        [self.m_commentArray removeAllObjects];
    }
    
    [self.m_commentArray addObjectsFromArray:self.m_array];
    NSLog(@"m_commentArray = %@",self.m_commentArray);
    
    // 显示出更早的消息后隐藏掉footerView
    self.m_tableView.tableFooterView = nil;
    
    [self.m_tableView reloadData];
    
}

- (void)cleanArray{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"确定删除所有消息？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    
    alertView.tag = 1123;
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1123 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 将类别的数据存储到plist里面用于网络不好时从plist里面读取
            NSFileManager *fm = [NSFileManager defaultManager];
            
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
            
            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID];
            
            NSString *finalPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_DynCommentList.plist",userId]];
            
            // 判断文件是否存在，如果存在则删除文件
            if ( [fm fileExistsAtPath:finalPath] ) {
                
                [fm removeItemAtPath:finalPath error:nil];
                
            }else{
                // plist不存在的话则直接清空服务端返回的数据所在的数组
                if ( self.m_commentArray.count != 0 ) {
                    
                    [self.m_commentArray removeAllObjects];
                }
            }
            
            // 返回上一级
            [self leftClicked];
        }
    }
    
}

@end
