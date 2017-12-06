//
//  CardMemeberDetaiViewController.m
//  HuiHui
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CardMemeberDetaiViewController.h"

#import "HH_MemberDetailCell.h"

#import "CardMenuOrderCell.h"

#import "MyCardCell.h"


@interface CardMemeberDetaiViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_accountDetailBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_accountRecordBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_cardName;

@property (weak, nonatomic) IBOutlet UILabel *m_cardNo;

@property (weak, nonatomic) IBOutlet UILabel *m_blance;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UITableView *m_recordTableView;

@property (weak, nonatomic) IBOutlet UITableView *m_detailTableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_starLabel;

@property (weak, nonatomic) IBOutlet UIView *m_view;

@property (weak, nonatomic) IBOutlet UIImageView *m_jantouImgV;


// 星级设置
- (IBAction)starClicked:(id)sender;

// 按钮点击方法
- (IBAction)btnClicked:(id)sender;

@end

@implementation CardMemeberDetaiViewController

@synthesize m_typeString;

@synthesize m_dic;

@synthesize m_recordList;

@synthesize m_status;

@synthesize m_menuOrderList;

@synthesize m_SectionsSet;

@synthesize m_starList;

@synthesize m_gradeName;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_recordList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_menuOrderList = [[NSMutableArray alloc]initWithCapacity:0];

        m_SectionsSet = [[NSMutableSet alloc]init];

        m_starList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_status = @"";
        
        m_index = -1;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"会员详情";
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    
    // 默认选中第一个
    [self setLeft:YES withRight:NO];
    
    // 设置图片圆角
    self.m_imageView.layer.cornerRadius = 30.0f;
    self.m_imageView.layer.masksToBounds = YES;
    
    // 赋值 [self.m_dic objectForKey:@"NickName"]
    self.m_cardName.text = [NSString stringWithFormat:@"会员姓名 %@",[self.m_dic objectForKey:@"RealName"]];

    
    [self.m_imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PhotoBigUrl"]]] placeholderImage:[UIImage imageNamed:@"moren.png"]];

    
    self.m_emptyLabel.hidden = YES;
    
    // 隐藏多余的额分割线
    [self setExtraCellLineHidden:self.m_recordTableView];
    
    // test ===
//    self.m_recordList = [NSMutableArray arrayWithObjects:@"12",@"100",@"55", nil];
    
//    self.m_menuOrderList = [NSMutableArray arrayWithObjects:@"红烧猪蹄",@"清蒸鱼",@"小龙虾", nil];

//    self.m_starList = [NSMutableArray arrayWithObjects:@"一星级",@"二星级",@"三星级", nil];

    
//    self.m_status = @"1";
    
    // 根据类型来判断显示
//    if ( [self.m_status isEqualToString:@"1"] ) {
//        
//        self.m_tipLabel.text = @"   会员卡历史订单";
//        
//    }else{
//        
//        self.m_tipLabel.text = @"   会员卡商品";
//
//    }
    
    // 设置view的边框颜色及宽度
    self.m_view.layer.borderWidth = 1.0f;
    self.m_view.layer.borderColor = RGBACKTAB.CGColor;
    
    self.m_imageView.layer.borderWidth = 1.0;
    self.m_imageView.layer.borderColor = RGBACKTAB.CGColor;
    
    
    self.m_gradeName = @"";
    
    // 会员卡等级列表请求数据
    [self levelRequest];
    

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftClicked{
    
    [self goBack];
    
}


- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        
        [self setLeft:YES withRight:NO];
        
    }else{
        
        [self setLeft:NO withRight:YES];
        
    }
    
}

- (void)setLeft:(BOOL)aLeft withRight:(BOOL)aRight{
    
    self.m_accountDetailBtn.selected = aLeft;
    self.m_accountRecordBtn.selected = aRight;
    
    if ( aLeft ) {
        
        self.m_accountDetailBtn.backgroundColor = RGBACKTAB;
        [self.m_accountDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.m_accountRecordBtn.layer.borderWidth = 1.0f;
        self.m_accountRecordBtn.layer.borderColor = RGBACKTAB.CGColor;
        self.m_accountRecordBtn.backgroundColor = [UIColor whiteColor];
        [self.m_accountRecordBtn setTitleColor:RGBACKTAB forState:UIControlStateNormal];

        self.m_accountDetailBtn.userInteractionEnabled = NO;
        self.m_accountRecordBtn.userInteractionEnabled = YES;
        
        // 设置类型
        self.m_typeString = @"1";
        
        self.m_detailTableView.hidden = NO;
        self.m_recordTableView.hidden = YES;
        
        // 获取会员卡某个用户的会员卡详细信息
        [self memberCardDetailRequest];
        
        
    }
    
    if ( aRight ) {
        
        self.m_accountRecordBtn.backgroundColor = RGBACKTAB;
        [self.m_accountRecordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.m_accountDetailBtn.layer.borderWidth = 1.0f;
        self.m_accountDetailBtn.layer.borderColor = RGBACKTAB.CGColor;
        self.m_accountDetailBtn.backgroundColor = [UIColor whiteColor];
        [self.m_accountDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [self.m_accountDetailBtn setTitleColor:RGBACKTAB forState:UIControlStateNormal];
        
        self.m_accountDetailBtn.userInteractionEnabled = YES;
        self.m_accountRecordBtn.userInteractionEnabled = NO;
        
        // 设置类型
        self.m_typeString = @"2";
        
        self.m_detailTableView.hidden = YES;
        self.m_recordTableView.hidden = NO;
        

        // 请求数据
        [self orderListRequest];
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ( tableView == self.m_detailTableView) {
        
        return self.m_menuOrderList.count;

    }else{
        
        return 1;

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ( tableView == self.m_detailTableView ) {
        
        BOOL expand = [self isSection:section];
        
        if ( !expand ) {
            
            if ( self.m_menuOrderList.count != 0 ) {
                
                NSDictionary *dic = [self.m_menuOrderList objectAtIndex:section];
                
                if ( [self.m_status isEqualToString:@"1"] ) {
                    
                    NSMutableArray *arr = [dic objectForKey:@"detailList"];
                    
                    return arr.count;
                    
                }else{
                    
                    NSMutableArray *arr = [dic objectForKey:@"RecordsList"];
                    
                    return arr.count;
                }
                
            }else{
                
                return 0;
                
            }
            
        }else {
            
            return 0;
            
        }
        
    }else{
        
        return self.m_recordList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = nil;

    if ( tableView == self.m_detailTableView ) {
        
        
        cell = [self DetailTableView:self.m_detailTableView cellForRowAtIndexPath:indexPath];

    }else{ //if ( tableView == self.m_recordTableView ){
       
        cell = [self RecordTableView:self.m_recordTableView cellForRowAtIndexPath:indexPath];
        
    }

    
    return cell;

}


- (UITableViewCell *)DetailTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( [self.m_status isEqualToString:@"1"] ) {
        
        static NSString *cellIdentifier = @"CardMenuOrderCellIdentifier";
        
        CardMenuOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CardMenuOrderCell" owner:self options:nil];
            
            cell = (CardMenuOrderCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        if ( self.m_menuOrderList.count != 0 ) {
            
            NSDictionary *dic = [self.m_menuOrderList objectAtIndex:indexPath.section];
            
            NSMutableArray *arr = [dic objectForKey:@"detailList"];
            
            if ( arr.count != 0 ) {
                
                NSDictionary *l_dic = [arr objectAtIndex:indexPath.row];
                
                cell.m_menuName.text = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"MenuName"]];
                cell.m_menuPrice.text = [NSString stringWithFormat:@"%@元",[l_dic objectForKey:@"MenuPrice"]];
                cell.m_menuCount.text = [NSString stringWithFormat:@"%@份",[l_dic objectForKey:@"MenuAmount"]];
                
            }
            
        }
        
        
        return cell;
        

        
    }else {
        
        static NSString *cellIdentifier = @"AccountProductCellIdentifier";
        
        AccountProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyCardCell" owner:self options:nil];
            
            cell = (AccountProductCell *)[nib objectAtIndex:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        if ( self.m_menuOrderList.count != 0 ) {
            
            NSDictionary *dic = [self.m_menuOrderList objectAtIndex:indexPath.section];

            NSMutableArray *arr = [dic objectForKey:@"RecordsList"];

            if ( arr.count != 0 ) {

                NSDictionary *l_dic = [arr objectAtIndex:indexPath.row];
                
                cell.m_name.text = [NSString stringWithFormat:@"%@份",[l_dic objectForKey:@"Amount"]];
                cell.m_time.text = [NSString stringWithFormat:@"使用时间:%@",[l_dic objectForKey:@"UseDate"]];
                
                cell.m_time.backgroundColor = [UIColor clearColor];
                
                cell.m_time.frame = CGRectMake(WindowSizeWidth - cell.m_time.frame.size.width - 40, cell.m_time.frame.origin.y, cell.m_time.frame.size.width, cell.m_time.frame.size.height);
            }
 
            
        }
        
        return cell;
   
    }
    
}

- (UITableViewCell *)RecordTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HH_MemberDetailCellIdentifier";
    
    HH_MemberDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_MemberDetailCell" owner:self options:nil];
        
        cell = (HH_MemberDetailCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 赋值
    if ( self.m_recordList.count != 0 ) {
        
        NSDictionary *dic = [self.m_recordList objectAtIndex:indexPath.row];
        
        cell.m_price.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Amount"]];
        
        cell.m_recordNo.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TransactionNumber"]];
       
        cell.m_recordType.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TransTypeName"]];
        
        cell.m_time.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TransDate"]];
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( tableView == self.m_detailTableView ) {
        
        if ( [self.m_status isEqualToString:@"1"] ) {
            
            return 60.0f;
            
        }else{
            
            return 44.0f;
            
        }
        
    }else{
        
        return 65.0f;
    
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( tableView == self.m_detailTableView ) {
        
        return 44.0f;
     
    }else{
        
        return 0.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ( tableView == self.m_detailTableView ) {
        
        if ( [self.m_status isEqualToString:@"1"] ) {
            
            if ( self.m_menuOrderList.count != 0 ) {
                
               NSDictionary *dic = [self.m_menuOrderList objectAtIndex:section];
                
                UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
                tempView.backgroundColor = [UIColor whiteColor];
                
                // 显示名称
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 180, 34)];
                
                label.text = [NSString stringWithFormat:@"%@ 购买",[dic objectForKey:@"CreateDate"]];
                
                //    label.textColor = RGBACKTAB;
                label.font = [UIFont systemFontOfSize:14.0f];
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = NSTextAlignmentLeft;
                [tempView addSubview:label];
                
                
                // 显示副标题
                UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(WindowSizeWidth - 100, 5, 65, 34)];
                
                subLabel.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"PriceAmount"]];
                
                subLabel.textColor = RGBACKTAB;
                subLabel.font = [UIFont systemFontOfSize:12.0f];
                subLabel.backgroundColor = [UIColor clearColor];
                subLabel.textAlignment = NSTextAlignmentRight;
                [tempView addSubview:subLabel];
                
                // 添加按钮
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0, 0, WindowSizeWidth, 44);
                [btn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = section;
                [tempView addSubview:btn];
                
                // 添加箭头变化的图片
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth - 30, 17, 16, 10)];
                
                BOOL expand = [self isSection:section];
                
                // 判断是展开还是闭合
                if ( expand ) {
                    
                    imgV.image = [UIImage imageNamed:@"arrow_L_up.png"];
                    
                } else {
                    
                    imgV.image = [UIImage imageNamed:@"arrow_L_down.png"];
                    
                }
                
                [tempView addSubview:imgV];
                
                
                return tempView;
                
                
            }

        }else{
            
            if ( self.m_menuOrderList.count != 0 ) {
                
                NSDictionary *dic = [self.m_menuOrderList objectAtIndex:section];
                
                
                UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
                tempView.backgroundColor = [UIColor whiteColor];
                
                // 显示名称
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 34)];
                
                label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
                
                //    label.textColor = RGBACKTAB;
                label.font = [UIFont systemFontOfSize:14.0f];
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = NSTextAlignmentLeft;
                [tempView addSubview:label];
                
                
                // 显示副标题
                UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(WindowSizeWidth - 80, 5, 40, 34)];
                
                subLabel.text = [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"UsedAmount"],[dic objectForKey:@"MenuAmount"]];
                
                subLabel.textColor = RGBACKTAB;
                subLabel.font = [UIFont systemFontOfSize:12.0f];
                subLabel.backgroundColor = [UIColor clearColor];
                subLabel.textAlignment = NSTextAlignmentRight;
                [tempView addSubview:subLabel];
                
                
                // 显示名称
                UILabel *label_1 = [[UILabel alloc]initWithFrame:CGRectMake(subLabel.frame.origin.x - 100, 5, 100, 34)];
                
                label_1.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateDate"]];
                
                label_1.textColor = [UIColor lightGrayColor];
                label_1.font = [UIFont systemFontOfSize:12.0f];
                label_1.backgroundColor = [UIColor clearColor];
                label_1.textAlignment = NSTextAlignmentRight;
                [tempView addSubview:label_1];
                
                
                // 添加按钮
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0, 0, WindowSizeWidth, 44);
                [btn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = section;
                [tempView addSubview:btn];
                
                // 添加箭头变化的图片
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth - 30, 17, 16, 10)];
                
                BOOL expand = [self isSection:section];
                
                // 根据使用的份数来判断按钮的显示图片
                if ( [[dic objectForKey:@"UsedAmount"]isEqualToString:@"0"] ) {
                    
                    imgV.image = [UIImage imageNamed:@""];
                    
                }else{
                
                    // 判断是展开还是闭合
                    if ( expand ) {
                        
                        imgV.image = [UIImage imageNamed:@"arrow_L_up.png"];
                        
                    } else {
                        
                        imgV.image = [UIImage imageNamed:@"arrow_L_down.png"];
                        
                    }
                    
                }
            
                [tempView addSubview:imgV];
                
                
                return tempView;
                
                
            }

        }
    }
    
    return nil;
}



// 判断是否展开
- (BOOL)isSection:(NSInteger)section{
    
    BOOL result = NO;
    
    if ( [self.m_SectionsSet containsObject:[NSNumber numberWithInteger:section]] ) {
        
        result = YES;
        
    }
    
    return result;
}

// 展开的section保存到expandedSectionsSet里面
- (void)setSection:(int)section expand:(BOOL)expand{
    
    if ( expand ) {
        
        if ( ![self.m_SectionsSet containsObject:[NSNumber numberWithInteger:section]] ) {
            // 首先是只显示一个点击展开的列表-即删除数据
            //            [self.m_SectionsSet removeAllObjects];
            //
            //            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
            
            // 如果展开全部的数据则写下面这行代码
            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
            
        }
        
    }else{
        // 如果展开全部的数据则写下面这行代码
        [self.m_SectionsSet removeObject:[NSNumber numberWithInteger:section]];
        
        // 首先是只显示一个点击展开的列表-即删除数据
        //        [self.m_SectionsSet removeAllObjects];
        
    }
    
}

- (void)headerClicked:(id)sender{
    
    // button的tag值
    UIButton *btn = (UIButton *)sender;
    
    //    sectionIndex = btn.tag;
    
    // bool值判断哪个section是展开还是合起来的
    BOOL expand = [self isSection:btn.tag];
    
    [self setSection:btn.tag expand:!expand];
    
    // 刷新tableView 展开全部的列表的话则就刷新某一行
    //    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.m_detailTableView reloadData];
    
    
}

- (IBAction)starClicked:(id)sender {
    
    // 选择座位 显示数据
    DownSheet *sheet = [[DownSheet alloc]initWithlist:menta height:0];
    sheet.delegate = self;
    sheet.m_index = m_index;
    [sheet showInView:nil];
    
}

// 初始化
- (void)initDemoData{
    
    menta = [[NSMutableArray alloc]initWithCapacity:0];
    
    if ( self.m_starList.count != 0 ) {
        
        for (int i = 0; i < self.m_starList.count; i++) {
            
            NSDictionary *dic = [self.m_starList objectAtIndex:i];
            
            DownSheetModel *Model = [[DownSheetModel alloc]init];
            
            Model.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GradeName"]];
            
//            Model.title = [NSString stringWithFormat:@"%@",[self.m_starList objectAtIndex:i]];
            
            [menta addObject:Model];
            
        }
        
    }else{
        
        DownSheetModel *Model_1 = [[DownSheetModel alloc]init];
        Model_1.title = @"暂无会员等级";
        
        menta = @[Model_1];
        
    }
    
}

- (void)didSelectIndex:(NSInteger)index{
    
    m_index = index;
    
    if ( self.m_starList.count != 0 ) {
        
        NSDictionary *dic = [self.m_starList objectAtIndex:index];
    
        // 赋值
        self.m_gradeName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GradeName"]];
        
        self.m_gradeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VIPCardGradeID"]];


        // 选择成功后请求数据
        [self changeLevelRequest];
        
        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"暂无暂无会员等级"];
        
        // 没有等级后设置数据为空
        self.m_starLabel.text = @"普通会员";

        // 设置箭头坐标
        [self setJiantouFrame];
        
    }
    
}

// 获取领取我会员卡的某个会员的账户详情
- (void)memberCardDetailRequest{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MemberID"]],@"xMemberID",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VIPCardMemberZHDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_blance.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"Balance"]];
            
            self.m_cardNo.text = [NSString stringWithFormat:@"会员卡号 %@",[json valueForKey:@"CardNumber"]];

            self.m_starLabel.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"GradeName"]];
            
            // 设置箭头坐标
            [self setJiantouFrame];
            
            // 会员卡历史订单的数组赋值
            
            self.m_emptyLabel.hidden = YES;
            
            // 根据类型来判断显示
            if ( [self.m_status isEqualToString:@"1"] ) {
                
                self.m_menuOrderList = [json valueForKey:@"OrderList"];
                
            }else{
                
                self.m_menuOrderList = [json valueForKey:@"OrderDetailList"];
                
            }


            if ( self.m_menuOrderList.count != 0 ) {
                
                if ( [self.m_status isEqualToString:@"1"] ) {
                    
                    self.m_tipLabel.text = @"   会员卡历史订单";
                    
                }else{
                    
                    self.m_tipLabel.text = @"   会员卡商品";
                    
                }
                
                
            }else{
                
                // 根据类型来判断显示
                if ( [self.m_status isEqualToString:@"1"] ) {
                    
                    self.m_tipLabel.text = @"   暂无会员卡历史订单";
                    
                }else{
                    
                    self.m_tipLabel.text = @"   暂无会员卡商品";
                    
                }
                

            }
            
            // 刷新列表
            [self.m_detailTableView reloadData];
            
           
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}



// 获取会员卡账户历史
- (void)orderListRequest{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberId",
                           key,@"Key",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MemberID"]],@"xMemberID",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"params = %@",param);
    
    [httpClient request:@"VIPCardMemberZHHistory.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
            
            // 赋值
            self.m_recordList = [json valueForKey:@"RecordList"];

            if ( self.m_recordList.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_recordTableView.hidden = NO;
                
                // 刷新列表
                [self.m_recordTableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_recordTableView.hidden = YES;

                
            }
        
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

// 请求会员卡等级的接口
- (void)levelRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VIPCardGradeList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
            
            // 赋值
            self.m_starList = [json valueForKey:@"GradeList"];
            
            // 初始化
            [self initDemoData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

// 更改会员卡等级请求数据
- (void)changeLevelRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MemberID"]],@"xMemberID",
                           [NSString stringWithFormat:@"%@",self.m_gradeId],@"VIPCardGradeID",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"SetVIPCardMemberGrade_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
//            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            NSLog(@"json = %@",json);
            
            // 成功后对label进行赋值
            self.m_starLabel.text = [NSString stringWithFormat:@"%@",self.m_gradeName];
           
            // 设置箭头坐标
            [self setJiantouFrame];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)setJiantouFrame{
    
    // 箭头紧跟在会员等级的后面
    CGSize size = [self.m_starLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_starLabel.frame = CGRectMake(self.m_starLabel.frame.origin.x, self.m_starLabel.frame.origin.y, size.width + 5, size.height);
    
    self.m_jantouImgV.frame = CGRectMake(self.m_starLabel.frame.origin.x + self.m_starLabel.frame.size.width + 5, self.m_jantouImgV.frame.origin.y, self.m_jantouImgV.frame.size.width, self.m_jantouImgV.frame.size.height);
}

@end
