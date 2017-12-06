//
//  CommentViewController.m
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "CommentViewController.h"

#import "CommentCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "UIImageView+AFNetworking.h"

@interface CommentViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation CommentViewController

@synthesize m_commentArray;

@synthesize m_starArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_commentArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_starArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        pageIndex = 1;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self setTitle:@"商品评价"];

    }else{
        
        [self setTitle:@"商户评价"];

    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 设置tableView的代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView= YES;
    self.m_tableView.hidden = YES;
    
    // 隐藏控件
    self.m_tableView.hidden = NO;
    
    self.m_emptyLabel.hidden = YES;
    
    
    // 判断是来自商户还是商品
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        // 请求数据
        [self requestCommentList];
        
    }else{
        
        [self requestMerchantComment];
    }

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
    
}

// 请求商户评价的数据
- (void)requestMerchantComment{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                  memberId,     @"memberId",
//                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",self.m_serviceId],   @"merchantId",
                                  [NSString stringWithFormat:@"%d",pageIndex],@"pageIndex",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantEvaluateList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"mctEvaluate"];
            if (pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.m_commentArray removeAllObjects];
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    return;
                } else {
                    self.m_commentArray = metchantShop;
                                        
                    self.m_emptyLabel.hidden = YES;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_commentArray addObjectsFromArray:metchantShop];
                }
            }
            [self.m_tableView reloadData];
            self.m_tableView.hidden = NO;
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
    
}

// 商品评价请求数据
- (void)requestCommentList{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",self.m_serviceId],   @"serviceId",
                                  [NSString stringWithFormat:@"%d",pageIndex],@"pageIndex",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ServiceEvaluateList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"svcEvaluate"];
            if (pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.m_commentArray removeAllObjects];
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    return;
                } else {
                    self.m_commentArray = metchantShop;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_commentArray addObjectsFromArray:metchantShop];
                }
            }
            [self.m_tableView reloadData];
            self.m_tableView.hidden = NO;
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        
    return [self.m_commentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"ShopListCellIdentifier";
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil];
        
        cell = (CommentCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         
    }
    
    if ( self.m_commentArray.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_commentArray objectAtIndex:indexPath.row];
                
        // 赋值
        cell.m_UserNameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Nick"]];
        
        NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Rank"]];
        // 评价星级的显示
        [cell setValue:string withCount:@""];
        
        
        // 设置图片
        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Logo"]]];
        
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateDate"]];
        
        cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]];
        
        CGSize size = [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, cell.m_contentLabel.frame.size.width, size.height+3);
        
        cell.frame = CGRectMake(0, 0, WindowSizeWidth, 78 + size.height + 5);
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic = [self.m_commentArray objectAtIndex:indexPath.row];
    
    CGSize size = [[dic objectForKey:@"Description"] sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

    return 78 + size.height + 5;
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self performSelector:@selector(requestCommentList) withObject:nil];
        
    }else{
        
        [self performSelector:@selector(requestMerchantComment) withObject:nil];
    }
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self performSelector:@selector(requestCommentList) withObject:nil];
        
    }else{
        
        [self performSelector:@selector(requestMerchantComment) withObject:nil];
    }
}

@end
