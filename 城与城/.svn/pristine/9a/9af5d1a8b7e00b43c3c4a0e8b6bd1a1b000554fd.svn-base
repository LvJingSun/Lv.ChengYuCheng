//
//  SceneryPictureViewController.m
//  HuiHui
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryPictureViewController.h"

#import "SceneryDetailCell.h"

#import "CommonUtil.h"

#import "MJPhoto.h"

#import "MJPhotoBrowser.h"

@interface SceneryPictureViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableview;

@end

@implementation SceneryPictureViewController

@synthesize m_imageList;

@synthesize m_imageUrl;

@synthesize m_sizeDic;

@synthesize m_PathDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_imageList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_sizeDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_PathDic = [[NSMutableDictionary alloc]initWithCapacity:0];

        m_pageIndex = 1;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"图片展示"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 测试
//    self.m_imageList = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1", nil];
    
    // 将多余的分割线去掉
    self.m_tableview.tableFooterView = [[UIView alloc]init];
    
    // 设置代理
    [self.m_tableview setDelegate:self];
    [self.m_tableview setDataSource:self];
    [self.m_tableview setPullDelegate:self];
    self.m_tableview.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableview.useRefreshView = YES;
    self.m_tableview.useLoadingMoreView = YES;
    
    
    // 根据数组是否有值来判断是否先要请求数据
    if ( self.m_imageList.count != 0 ) {
        
        [self.m_tableview reloadData];
        
    }else{
        
        // 默认隐藏tableView
        self.m_tableview.hidden = YES;
        
        m_pageIndex = 1;
        
        // 请求数据
        [self sceneryPictureListRequest];
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

#pragma mark - NetWork
- (void)sceneryPictureListRequest{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    //
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",self.m_sceneryId],@"sceneryId",
                           [NSString stringWithFormat:@"%i",m_pageIndex],@"page",
                           @"20",@"pageSize",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Scenery/GetSceneryImageList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 图片赋值
            self.m_PathDic = [json valueForKey:@"imagelist"];
            
            self.m_sizeDic = [json valueForKey:@"extInfoOfImageList"];
            
            
            NSMutableArray *imageList = [self.m_PathDic objectForKey:@"image"];
            
            if (m_pageIndex == 1) {
                
                if (imageList == nil || imageList.count == 0) {
                    
                    [self.m_imageList removeAllObjects];
                    
                    [self.m_tableview reloadData];
                    
                    self.m_tableview.hidden = YES;
                    
                    return;
                    
                } else {
                    
                    self.m_imageList = imageList;
                    
                    // 判断imageUrl是否等于空，没要值的话要重新赋值
                    if ( [self.m_imageUrl isEqualToString:@"(null)"] || self.m_imageUrl.length == 0 ) {
                        
                        NSString *imageUrl = [NSString stringWithFormat:@"%@",[self.m_sizeDic objectForKey:@"imageBaseUrl"]];
                        
                        // 取出图片size的大小
                        NSString *l_size = @"";
                        
                        NSMutableArray *arr = [self.m_sizeDic objectForKey:@"sizeCodeList"];
                        
                        if ( arr.count != 0 ) {
                            
                            // 获取300*225  740_350 的尺寸用于图片列表进行显示
                            // 获取尺寸用于图片列表进行显示
                            NSDictionary *l_dic = [arr objectAtIndex:arr.count - 1];
                            
                            l_size = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"size"]];
                            
                        }
                        
                        // 拼接成图片字符地址
                        self.m_imageUrl = [NSString stringWithFormat:@"%@%@/",imageUrl,l_size];
                        
                    }
                    
                    self.m_tableview.hidden = NO;
                    
                }
            } else {
                
                self.m_tableview.hidden = NO;
                
                if (imageList == nil || imageList.count == 0) {
                    
                    m_pageIndex--;
                    
                } else {
                    
                    [self.m_imageList addObjectsFromArray:imageList];
                }
            }
            
            [self.m_tableview reloadData];
            
        } else {
            
            if (m_pageIndex > 1) {
                m_pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        self.m_tableview.pullLastRefreshDate = [NSDate date];
        self.m_tableview.pullTableIsRefreshing = NO;
        self.m_tableview.pullTableIsLoadingMore = NO;
        
    } failure:^(NSError *error) {
        if (m_pageIndex > 1) {
            m_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableview.pullTableIsRefreshing = NO;
        self.m_tableview.pullTableIsLoadingMore = NO;
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_imageList.count % 3 == 0 ? [self.m_imageList count] / 3 : [self.m_imageList count] / 3 + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryPictureCellIdentifier";
    SceneryPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryDetailCell" owner:self options:nil];
        
        cell = (SceneryPictureCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    
    cell.m_leftImgV.hidden = NO;
    cell.m_middleImgV.hidden = NO;
    cell.m_rightImgV.hidden = NO;
    
    cell.m_leftImgV.contentMode = UIViewContentModeScaleAspectFit;

    cell.m_middleImgV.contentMode = UIViewContentModeScaleAspectFit;

    cell.m_rightImgV.contentMode = UIViewContentModeScaleAspectFit;

    
    if (indexPath.row * 3 + 0 <= [self.m_imageList count] - 1 ) {
        
         NSDictionary *dic = [self.m_imageList objectAtIndex:indexPath.row * 3 + 0];
        
         NSString *imagePath = [NSString stringWithFormat:@"%@%@",self.m_imageUrl,[dic objectForKey:@"imagePath"]];
        
         [cell setImageLeft:imagePath];
        
        [cell.m_leftImgV setContentMode:UIViewContentModeScaleAspectFit];
        
        if (indexPath.row * 3 + 1 > [self.m_imageList count] - 1) {
           
            cell.m_middleImgV.hidden = YES;
            cell.m_middleBtn.userInteractionEnabled = NO;
            cell.m_rightImgV.hidden = YES;
            cell.m_rightBtn.userInteractionEnabled = NO;
        }
        
        cell.m_leftBtn.tag = indexPath.row * 3 + 0;
        cell.m_leftImgV.tag = indexPath.row * 3 + 0;
        
        // 添加按钮点击事件
        [cell.m_leftBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (indexPath.row * 3 + 1 <=  [self.m_imageList count] - 1) {
        
        NSDictionary *dic = [self.m_imageList objectAtIndex:indexPath.row * 3 + 1];
        
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",self.m_imageUrl,[dic objectForKey:@"imagePath"]];
        
        [cell setImageMiddle:imagePath];
        
        [cell.m_middleImgV setContentMode:UIViewContentModeScaleAspectFit];
        
        
        if (indexPath.row * 3 + 2 > [self.m_imageList count] - 1) {
            
            cell.m_rightImgV.hidden = YES;
            cell.m_rightBtn.userInteractionEnabled = NO;
            
        }
        
        cell.m_middleBtn.tag = indexPath.row * 3 + 1;
        
        cell.m_middleImgV.tag = indexPath.row * 3 + 1;
        
        // 添加按钮点击事件
        [cell.m_middleBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (indexPath.row * 3 + 2 <=  [self.m_imageList count] - 1) {
        
        NSDictionary *dic = [self.m_imageList objectAtIndex:indexPath.row * 3 + 2];
        
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",self.m_imageUrl,[dic objectForKey:@"imagePath"]];
        
        [cell setImageRight:imagePath];
        
        [cell.m_rightImgV setContentMode:UIViewContentModeScaleAspectFit];
        
        cell.m_rightBtn.tag = indexPath.row * 3 + 2;
        
        cell.m_rightImgV.tag = indexPath.row * 3 + 2;
        
        // 添加按钮点击事件
        [cell.m_rightBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
    
   
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 78.0f;
    
}

#pragma mark - BtnClicked
- (void)btnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.m_imageList count]];
    
    for (int i = 0; i < [self.m_imageList count]; i++) {
        // 替换为中等尺寸图片
//        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [self.m_imageList objectAtIndex:i]];
        
        NSDictionary *dic = [self.m_imageList objectAtIndex:i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        photo.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.m_imageUrl,[dic objectForKey:@"imagePath"]]]; // 图片路径
        
//        photo.image = [self.m_imageList objectAtIndex:i];
        
//        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: btn.tag];
//        photo.srcImageView = imageView;
        [photos addObject:photo];
        
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = btn.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];

}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    m_pageIndex = 1;
    [self performSelector:@selector(sceneryPictureListRequest) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    m_pageIndex++;
    [self performSelector:@selector(sceneryPictureListRequest) withObject:nil];
}


@end
