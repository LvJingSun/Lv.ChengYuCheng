//
//  AddBCMenuViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-5-21.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "AddBCMenuViewController.h"
#import "AddBCMenuTableViewCell.h"
#import "UIImageView+AFNetworking.h"

#import "HH_CustomMenuCell.h"
#import "LJNewCell.h"
#import "LJSettingCell.h"
#import "SetYongjinCell.h"
#import "LJTimeCell.h"


#define TOSHOPKEY  @"ToShopKey"
#define TOHOMEKEY  @"ToHomeKey"

@interface AddBCMenuViewController (){

    UISwitch *ljswitch;
    
    NSString *isOpen;
    
    NSString *isFuWuXiangMu;
    
    NSString *shiChang;
    
    NSString *yongJinBiLis;
    
    NSMutableArray *mutAr;
    
    NSMutableArray *countMutArr;
}

@property (nonatomic,strong) NSMutableArray *m_shopList;
@property (nonatomic, strong) NSMutableDictionary   *m_imagDic;

@property (nonatomic, strong) NSArray *levelArray;

@property (nonatomic, weak) UITextField *editingField;

@end

@implementation AddBCMenuViewController

@synthesize m_menuClassId;
@synthesize m_imagDic;
@synthesize m_type;
@synthesize m_dic;
@synthesize m_isChange;
@synthesize m_selectDic;
@synthesize m_buy;
@synthesize m_card;
@synthesize m_opend;
@synthesize m_pinlv;
@synthesize m_tejia;
@synthesize m_starList;
@synthesize m_height;
@synthesize m_accountList;
@synthesize m_openedDic;
@synthesize m_cardDic;
@synthesize m_cardDic1;
@synthesize m_customMenuName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_imagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.m_shopList = [[NSMutableArray alloc]initWithCapacity:0];

        m_selectDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_starList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_height = 0.0;
        
        m_openedDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_accountList = [[NSMutableArray alloc]initWithCapacity:0];

        m_cardDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_cardDic1 = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self requestLevelData];
    
    
    mutAr = [NSMutableArray array];
    
    countMutArr = [NSMutableArray array];
    
    
    [self setRightButtonWithTitle:@"自定义" action:@selector(CustomMenu)];
    
    // 根据类型来判断是新增还是编辑
    if ( [self.m_type isEqualToString:@"1"] ) {
        
//        [self setTitle:@"增加菜单"];
        
        isOpen = @"关闭";
        
        isFuWuXiangMu = @"0";
        
        shiChang = @"";
        
        yongJinBiLis = @"";
        
        [self setTitle:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MENUCLASSNAME]]];
        
        
        // 默认选中第一个-到店消费
        [self.m_selectDic setObject:@"1" forKey:TOSHOPKEY];
        [self.m_selectDic setObject:@"0" forKey:TOHOMEKEY];
        
        // 默认全公开
        self.m_buy = 0;
        self.m_card = 0;
        self.m_opend = 0;
        self.m_pinlv = 0;
        
        dabaofeiString = @"";
        description = @"";
        usedCount = @"";
        totalUsedCount = @"";
        PinlvDay=@"";
        self.m_customMenuName = @"";
        [self.m_cardDic setObject:@"" forKey:@"20000"];
        
    }else{
        
        if ([self.isFuWu isEqualToString:@"0"]) {
            
            isOpen = @"关闭";
            
            isFuWuXiangMu = @"0";
            
            shiChang = @"";
            
            yongJinBiLis = @"";
            
        }else {
        
            isOpen = @"开启";
            
            isFuWuXiangMu = @"1";
            
            shiChang = self.shijian;
            
            yongJinBiLis = [self arrayToJson:self.biliArray];
            
        }
        
//        [self setTitle:@"编辑菜单"];
        
        [self setTitle:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MENUCLASSNAME]]];
        
        [self.m_cardDic setObject:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MenuPriceCC"]] forKey:@"20000"];

        
        self.m_isChange = @"0";
        
        // 赋值
        menunamestring = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MenuName"]];

        pricestring = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MenuPrice"]];

        shopIDstring = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MerchantShopID"]];

        shopnamestring = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MerchantShopName"]];
        
        // 可支持的店铺列表
        self.m_shopList = [self.m_dic objectForKey:@"MctShopList"];
        
        
        description = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Description"]];
        
        
        // 是否到点消费
        NSString *IsDDXF = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsDDXF"]];
        
        if ( [IsDDXF isEqualToString:@"1"] ) {
            
            [self.m_selectDic setObject:IsDDXF forKeyedSubscript:TOSHOPKEY];
            
        }else{
            
            [self.m_selectDic setObject:@"0" forKeyedSubscript:TOSHOPKEY];

        }
        
        // 是否支持送货上门
        NSString *IsHomeDelivery = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsHomeDelivery"]];
      
        if ( [IsHomeDelivery isEqualToString:@"1"] ) {
            
            [self.m_selectDic setObject:IsHomeDelivery forKeyedSubscript:TOHOMEKEY];
            
            dabaofeiString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PackingPrice"]];
            
            
        }else{
            
            [self.m_selectDic setObject:@"0" forKeyedSubscript:TOHOMEKEY];
            
            dabaofeiString = @"";
            
        }
        
        // 是否支持对用户公开
        NSString *IsInside = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsInside"]];
       
        if ( [IsInside isEqualToString:@"1"] ) {
       
            m_opend = 1;
            
        
        }else{
            
            m_opend = 0;
            
        }
        

        // 是否支持限购
        NSString *IsXG = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsXG"]];

        if ( [IsXG isEqualToString:@"1"] ) {
            
            m_buy = 1;
            
            totalUsedCount = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"XGAmountTotal"]];

            usedCount = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"XGAmount"]];

        }else{
            
            m_buy = 0;
            
            totalUsedCount = @"";
            
            usedCount = @"";
        }
        //限制频率
//        NSLog(@"%@",[self.m_dic JSONString]);
        NSString *IsPL = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsXZPL"]];
        if ([IsPL isEqualToString:@"1"]) {
            PinlvDay = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"XZDays"]];
            self.m_pinlv = 1;
        }else{
            PinlvDay = @"";
            self.m_pinlv = 0;
        }
        
        //特价区
        NSString *IsZCTJ = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsZCTJ"]];
        if ([IsZCTJ isEqualToString:@"1"]) {
            self.m_tejia = 1;
        }else{
            self.m_tejia = 0;
        }
        
        // 是否支持会员卡活动
        NSString *IsZCVIPCardGrade = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsZCVIPCardGrade"]];

        if ( [IsZCVIPCardGrade isEqualToString:@"1"] ) {
            
            m_card = 1;
            
        }else{
            
            m_card = 0;
            
        }
        
        
        // 计算自定义参数的方法
        [self customPramater];
      
    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.ABCMTableview addGestureRecognizer:gestureRecognizer];
    
//    [self AllocABCM];
    
    // 请求会员等级数据的
    [self levelRequest];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customPramater{
    
    NSMutableArray *l_arr = [self.m_dic objectForKey:@"AttributeList"];
    
    // 根据自定义返回的数组来拼接成自定义的字符串
    if ( l_arr.count != 0 ) {
        
        NSString *ll_string = @"";
        
        for (int i = 0; i < l_arr.count; i++) {
            
            NSDictionary *dic = [l_arr objectAtIndex:i];
            
            NSString *menuName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeName"]];
            
            NSArray *arr = [dic objectForKey:@"ValueList"];
            
            NSString *l_string = @"";
            
            NSString *l_AttributeID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeID"]];
            
            NSString *AttributeID = @"";
            
            if ( [l_AttributeID isEqualToString:@"(null)"] || l_AttributeID.length == 0 ) {
                
                AttributeID = @"";
                
            }else{
                
                AttributeID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeID"]];
            }
            
            
            for (int ii = 0; ii < arr.count; ii++) {
                
                NSDictionary *l_dic = [arr objectAtIndex:ii];
                
                NSString *menu_name = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"Value"]];
                
                NSString *l_ValueID = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"ValueID"]];
                
                NSString *ValueID = @"";
                
                if ( [l_ValueID isEqualToString:@"(null)"] || l_ValueID.length == 0 ) {
                    
                    ValueID = @"";
                    
                }else{
                    
                    ValueID = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"ValueID"]];
                    
                }
                
                // 赋值
                if ( ii != arr.count - 1 ) {
                    
                    l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"{\"ValueID\":\"%@\",\"Value\":\"%@\"},",ValueID,menu_name]];
                    
                }else{
                    
                    l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"{\"ValueID\":\"%@\",\"Value\":\"%@\"}",ValueID,menu_name]];
                    
                }
                
                
            }
            
            
            
            l_string = [NSString stringWithFormat:@"\"ValueList\":[%@]",l_string];
            
            
            // 赋值
            if ( i != l_arr.count - 1 ) {
                
                ll_string = [ll_string stringByAppendingString:[NSString stringWithFormat:@"{\"AttributeID\":\"%@\",\"AttributeName\":\"%@\",%@},",AttributeID,menuName,l_string]];
                
            }else{
                
                ll_string = [ll_string stringByAppendingString:[NSString stringWithFormat:@"{\"AttributeID\":\"%@\",\"AttributeName\":\"%@\",%@}",AttributeID,menuName,l_string]];
                
                
            }
            
            
        }
        
        self.m_customMenuName = [NSString stringWithFormat:  @"\{\"Attributelist\":[%@]}",ll_string];
        
    }else{
        
        self.m_customMenuName = @"";
        
    }
    
   
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)CustomMenu{
    
    // 进入自定义菜单的页面
    HH_CustomMenuViewController *VC = [HH_CustomMenuViewController shareobject];//[[HH_CustomMenuViewController alloc]initWithNibName:@"HH_CustomMenuViewController" bundle:nil];
    VC.m_menuClassId = [NSString stringWithFormat:@"%@",self.m_menuClassId];
    VC.m_dic = self.m_dic;
    VC.m_type = self.m_type;
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - CustomDelegate
- (void)getCustomMenuName:(NSString *)aString{
 
    // 如果选择了值的话则再次进入这个页面的时候就保存原来的选择
    [CommonUtil addValue:@"1" andKey:@"Custom_menu_Key"];
    
    // 赋值
    self.m_customMenuName = [NSString stringWithFormat:@"%@",aString];
    
}

// 初始化scrollerView
- (void)initwithScroller:(UIScrollView *)scrollerView{
    
    for ( id view1 in scrollerView.subviews ) {
        
        if ( [view1 isKindOfClass:[UIView class]] ) {
            
            UIView *l_view = (UIView *)view1;
            
            [l_view removeFromSuperview];
        }
    }
    
    int width = (WindowSizeWidth - 40)/3;
    
    for (int i = 0; i < self.m_starList.count; i++) {
        
        NSDictionary *dic = [self.m_starList objectAtIndex:i];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i % 3 * (width + 10),  i / 3 * 40, width, 30)];
        
        view.backgroundColor = [UIColor clearColor];
        [scrollerView addSubview:view];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width - 30, view.frame.size.height)];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GradeName"]];
        label.textColor = [UIColor blackColor];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(view.frame.size.width - 30, 0, 30, view.frame.size.height);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;

        // 判断按钮的显示图片
        NSString *string = [NSString stringWithFormat:@"%@",[self.m_openedDic objectForKey:[NSString stringWithFormat:@"%i",i]]];
        
        if ( [string isEqualToString:@"1"] ) {
            
            [btn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];

        }else{
            
            [btn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

        }
        
        [btn addTarget:self action:@selector(starBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:label];
        [view addSubview:btn];
        
        [scrollerView addSubview:view];
        
    }
    
}

- (void)starBtnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSString *string = [NSString stringWithFormat:@"%@",[self.m_openedDic objectForKey:[NSString stringWithFormat:@"%i",btn.tag]]];
    
    // 获得等级的id，和数组里的进行比较，如果是选中的话，则加入数组，如果是不选中的话则从数组中删除
    NSDictionary *dic = [self.m_starList objectAtIndex:btn.tag];
    
    NSString *gradeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VIPCardGradeID"]];
    
    
    // 如果是1 的话则表示选中的状态 0的话则表示未选中的状态
    if ( [string isEqualToString:@"1"] ) {
        
        string = @"0";
        
        // 如果数组里面包含这个值的话则删除这个值
        if ( [self.m_accountList containsObject:gradeId] ) {
            
            [self.m_accountList removeObject:gradeId];
            
        }
        
    }else{
        
        string = @"1";
        
        [self.m_accountList addObject:gradeId];

    }
    
    
    [self.m_openedDic setObject:string forKey:[NSString stringWithFormat:@"%i",btn.tag]];
    
    // 刷新某一行
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
    
    [self.ABCMTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
  

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( section == 0) {
    
        if ([isOpen isEqualToString:@"关闭"]) {
            
            return 1;
            
        }else {
        
            return self.levelArray.count + 2;
            
        }
        
    }else if ( section == 1 ) {
        
        // 根据是否对用户公开和是否支持送货上门来判断显示几行
        NSString *toHome = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOHOMEKEY]];
        
        if ( [toHome isEqualToString:@"1"] ) {
            
            return 5;

        }else{
            
            return 4;

        }
        
    }else if ( section == 2 ) {
        
        if (  self.m_card == 1 ) {
            
            return 3 + self.m_starList.count;
            
        }else{
            
            return 3 ;

 
        }
        
        
    }else if ( section == 3 ){
        
        return 3;
        
    }else if ( section == 4 ){
        
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 4 ) {
        
        AddBCMenuTableViewCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBCMenuTableViewCell2"];
        
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:2];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        
        // 保存按钮添加点击事件
        [cell.m_Save addTarget:self action:@selector(saveMenuCilcked) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
        
    }else{
        
        if ( indexPath.section == 0) {
            
            if ([isOpen isEqualToString:@"关闭"]) {
                
                if (indexPath.row == 0) {
                    
                    LJNewCell *cell = [[LJNewCell alloc] init];
                    
                    ljswitch = cell.LJswitch;
                    
                    ljswitch.tag = 999;
                    
                    [ljswitch addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    ljswitch.on = NO;
                    
                    return cell;
                    
                }
                
            }else {
            
                if (indexPath.row == 0) {
                    
                    LJSettingCell *cell = [[LJSettingCell alloc] init];
                    
                    ljswitch = cell.LJswitch;
                    
                    ljswitch.tag = 999;
                    
                    [ljswitch addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    ljswitch.on = YES;
                    
                    return cell;
                    
                }else if (indexPath.row == self.levelArray.count + 1) {
                
                    LJTimeCell *cell = [[LJTimeCell alloc] init];
                    
                    cell.timeField.delegate = self;
                    
                    cell.timeField.tag = 808;
                    
                    if (shiChang.length == 0) {
                        
                    }else {
                    
                        cell.timeField.text = [NSString stringWithFormat:@"%@",shiChang];
                        
                    }
                    
                    return cell;
                    
                }else {
                
                    for (int i = 0; i < self.levelArray.count; i ++) {
                        
                        if (indexPath.row == i + 1) {
                            
                            NSDictionary *dic = self.levelArray[i];
                            
                            SetYongjinCell *cell = [[SetYongjinCell alloc] init];
                            
                            cell.countField.delegate = self;
                            
                            cell.countField.tag = i;
                            
                            cell.levelNameLabel.text = dic[@"MingCheng"];
                            
                            if (self.biliArray.count == 0) {
                                
                                
                                
                                
                            }else {
                            
                                for (NSDictionary *dict in self.biliArray) {
                                    
                                    if ([dic[@"MingCheng"] isEqualToString:dict[@"MingCheng"]]) {
                                        
                                        cell.countField.text = dict[@"YongJinBiLi"];
                                        
                                        NSDictionary *json = @{@"YongJinLevelID":dict[@"YongJinLevelID"],@"YongJinBiLi":cell.countField.text};
                                        
                                        [mutAr addObject:json];
                                        
                                    }
                                }
                            }
                            
                            if ([self.m_type isEqualToString:@"2"]) {

                                if (countMutArr.count < self.levelArray.count) {
                                    
                                    [countMutArr addObject:cell.countField.text];
                                    
                                }
                                
                                if (i < countMutArr.count) {
                                    
                                    cell.countField.text = countMutArr[i];
                                    
                                }
                                
                                
                                
                                
                            }else {
                            
                                if (countMutArr.count < self.levelArray.count) {
                                    
                                    [countMutArr addObject:@""];
                                    
                                }
                                
                                if (countMutArr.count == 0) {
                                    
                                }else {
                                    
                                    if (i >= countMutArr.count) {
                                        
                                        cell.countField.text = @"";
                                        
                                    }else {
                                        
                                        cell.countField.text = countMutArr[i];
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                            return cell;
                            
                        }
                    }
                    
                    
                }
                
            }
            
        }else if ( indexPath.section == 1 ) {
            
            // 保存按钮添加点击事件
            
            if ( indexPath.row == 0 ) {
                
                HH_CustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HH_CustomCellIdentifier"];
                
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"HH_CustomMenuCell" owner:self options:nil]objectAtIndex:1];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    
                    
                }
                
                cell.m_switcher.tag = indexPath.row;
                
                if ( self.m_opend == 1 ) {
                    
                    [cell.m_switcher setOn:YES];
                    
                    cell.m_titleLabel.text = @"对部分用户公开";
                    
                    cell.m_scrollerView.hidden = NO;
                    
                    // 初始化scrollerView
                    [self initwithScroller:cell.m_scrollerView];
                    
                    cell.m_scrollerView.backgroundColor = [UIColor clearColor];
                    
//                    cell.m_scrollerView.frame = CGRectMake(8, 44, WindowSizeWidth - 16, 60);
                    
                    cell.m_scrollerView.frame = CGRectMake(8, 44, WindowSizeWidth - 16, self.m_height);
                    
                    cell.m_lineImagV.frame = CGRectMake(cell.m_lineImagV.frame.origin.x, 43 + self.m_height, cell.m_lineImagV.frame.size.width, 1);
                    
                    cell.m_switcher.frame = CGRectMake(WindowSizeWidth - 67, 6, cell.m_switcher.frame.size.width, cell.m_switcher.frame.size.height);
                    
                    
                }else{
                    
                    [cell.m_switcher setOn:NO];
                    
                    cell.m_titleLabel.text = @"对所有用户公开";
                    
                    cell.m_scrollerView.hidden = YES;

                    cell.m_lineImagV.frame = CGRectMake(cell.m_lineImagV.frame.origin.x, 43, cell.m_lineImagV.frame.size.width, 1);

                     cell.m_switcher.frame = CGRectMake(WindowSizeWidth - 67, 6, cell.m_switcher.frame.size.width, cell.m_switcher.frame.size.height);
                    
                }
                
                [cell.m_switcher addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                
                return cell;

                
            } else if ( indexPath.row == 1 ){
              
                // 判断是否限制购买
                if ( self.m_buy == 1 ) {
                    
                    HH_CustomBuyedCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HH_CustomBuyedCellIdentifier"];
                    
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle]loadNibNamed:@"HH_CustomMenuCell" owner:self options:nil]objectAtIndex:2];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }
                    
                    //是否限制频率
                    if (self.m_pinlv ==1) {
                        cell.m_PinglvSerYES.hidden = NO;
                        cell.m_PinglvSerNO.hidden = YES;
                        cell.m_pinlvdayTextField.delegate = self;
                        cell.m_pinlvnumTextField.delegate = self;

                    }else
                    {
                        cell.m_PinglvSerYES.hidden = YES;
                        cell.m_PinglvSerNO.hidden = NO;
                        cell.m_pinlvdayTextField.delegate = nil;
                        cell.m_pinlvnumTextField.delegate = nil;
                    }
                    
                    
                    cell.m_switcher.tag = indexPath.row;
                    
                    [cell.m_switcher setOn:YES];
                    
                    cell.m_titleLabel.text = @"限制购买";
                    
                    cell.m_totalTextField.delegate = self;
                    cell.m_usedTextField.delegate = self;
                    
                    cell.m_pinlvdayTextField.text = [NSString stringWithFormat:@"%@",PinlvDay];
                    cell.m_totalTextField.text = [NSString stringWithFormat:@"%@",totalUsedCount];
                    cell.m_usedTextField.text = [NSString stringWithFormat:@"%@",usedCount];
                    cell.m_pinlvnumTextField.text = [NSString stringWithFormat:@"%@",usedCount];
                    cell.m_totalTextField.tag = 101;
                    cell.m_usedTextField.tag = 102;
                    
                    [cell.m_switcher addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
                    

                    cell.m_switcher.frame = CGRectMake(WindowSizeWidth - 67, 6, cell.m_switcher.frame.size.width, cell.m_switcher.frame.size.height);

                    [cell.m_PinglvSer setOn:self.m_pinlv];
                    [cell.m_PinglvSer addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
                    cell.m_PinglvSer.frame = CGRectMake(WindowSizeWidth - 77, 6, cell.m_PinglvSer.frame.size.width, cell.m_PinglvSer.frame.size.height);
                    
                    
                    return cell;

                    
                }else{
                    
                    
                    HH_CustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HH_CustomCellIdentifier"];
                    
                    if (!cell)
                    {
                        cell = [[[NSBundle mainBundle]loadNibNamed:@"HH_CustomMenuCell" owner:self options:nil]objectAtIndex:1];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }
                    
                    
                    
                    cell.m_switcher.tag = indexPath.row;
                    
                    [cell.m_switcher setOn:NO];
                    
                    cell.m_titleLabel.text = @"不限制购买";
                    
                    [cell.m_switcher addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.m_switcher.frame = CGRectMake(WindowSizeWidth - 67, 6, cell.m_switcher.frame.size.width, cell.m_switcher.frame.size.height);

                    
                    return cell;

                }
                
                
                
            } else if ( indexPath.row == 2 ){
                // 是否显示在特价区
                HH_TejiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HH_TejiaCell"];
                
                if (!cell)
                {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"HH_CustomMenuCell" owner:self options:nil]objectAtIndex:4];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    
                }
                
                [cell.m_switcher setOn:self.m_tejia];
                [cell.m_switcher addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];

                
                return cell;
                
            } else if ( indexPath.row == 3 ){
                
                // 销售方式
                AddMenuStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddMenuStyleCellIdentifier"];
                
                if (!cell)
                {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:3];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    
                }
                
                
                // 根据值来判断按钮的显示图片
                NSString *toshop = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOSHOPKEY]];
                NSString *toHome = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOHOMEKEY]];
                
                if ( [toshop isEqualToString:@"1"] ) {
                    
                    [cell.m_currentBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
                    
                }else{
                    
                    [cell.m_currentBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
                    
                }
                
                if ( [toHome isEqualToString:@"1"] ) {
                    
                    [cell.m_songhuoBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
                    
                    cell.m_imageV.hidden = NO;
                    
                    
                }else{
                    
                    [cell.m_songhuoBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
                    
                    cell.m_imageV.hidden = YES;

                }
                
                cell.m_currentBtn.tag = 111;
                cell.m_songhuoBtn.tag = 222;
                
                // 添加按钮的点击方法
                [cell.m_currentBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell.m_songhuoBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                
                return cell;
                
            }else{
                
                // 根据是否对用户公开和是否支持送货上门来判断显示几行
                NSString *toHome = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOHOMEKEY]];
                
                if ( [toHome isEqualToString:@"1"] ) {
                    AddBCMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBCMenuTableViewCell"];
                    
                    if (!cell)
                    {
                        cell=[[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:0];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }
                    
                    cell.m_labelfield.delegate = self;
                    cell.m_btn.hidden = YES;
                    
                    cell.m_labeltext.text = @"打包费";
                    cell.m_labelfield.placeholder = @"请输入打包费";
                    cell.m_labelfield.text = dabaofeiString;
                    cell.m_labelfield.tag = 203;
                    

                    return cell;

                }else{
                    
                    return nil;
                }
                
                
            }
            
        }else if ( indexPath.section == 2 ) {
            
            if ( self.m_card == 1 ) {
                
                if ( indexPath.row == 1 ) {
                    
                    HH_OrignCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HH_OrignCellIdentifier"];
                    
                    if (!cell)
                    {
                        cell=[[[NSBundle mainBundle]loadNibNamed:@"HH_CustomMenuCell" owner:self options:nil]objectAtIndex:3];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }

                    cell.m_textField.delegate = self;

                    cell.m_textField.placeholder = @"请输入价格";
                    cell.m_textField.text = pricestring;
                    cell.m_textField.tag = 202;
                    
                    // 打开的时候表示参加会员卡活动
                    cell.m_titleLabel.text = @"参加会员卡活动";
                    cell.m_switcher.tag = 1021;
                    
                    [cell.m_switcher setOn:YES];

                    [cell.m_switcher addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    cell.m_switcher.frame = CGRectMake(WindowSizeWidth - 67, 6, cell.m_switcher.frame.size.width, cell.m_switcher.frame.size.height);

                    return cell;
                    
                }else if (indexPath.row==2){
                
                    AddBCMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBCMenuTableViewCell"];
                    
                    if (!cell)
                    {
                        cell=[[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:0];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }
                    
                    cell.m_labelfield.delegate = self;
                    cell.m_btn.hidden = YES;
                    cell.m_labeltext.text = @"城与城价格";
                    cell.m_labelfield.placeholder = @"请输入价格";
                    
                    cell.m_labelfield.font = [UIFont systemFontOfSize:14.0f];
                    
                    cell.m_labelfield.text = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:@"20000"]];
                    cell.m_labelfield.tag = 20000;
                    
                    
                    return cell;
                
                
                }
                else{
                    
                    
                    AddBCMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBCMenuTableViewCell"];
                    
                    if (!cell)
                    {
                        cell=[[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:0];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }
                    
                    cell.m_labelfield.delegate = self;
                    cell.m_btn.hidden = YES;
                    
                    
                    if (indexPath.row == 0) {
                        
                        cell.m_labeltext.text = @"菜单";
                        cell.m_labelfield.placeholder = @"请输入菜单名称";
                        cell.m_labelfield.text = menunamestring;
                        cell.m_labelfield.tag = 201;
                        
                        cell.m_labelfield.font = [UIFont systemFontOfSize:14.0f];

                    }
                    else {
                        NSLog(@"%@",self.m_cardDic);
                        if ( self.m_starList.count != 0 ) {
                            
                            NSDictionary *dic = [self.m_starList objectAtIndex:indexPath.row - 3];
                            
                            cell.m_labeltext.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GradeName"]];
                            cell.m_labelfield.placeholder = @"请输入价格";
                            
                            cell.m_labelfield.font = [UIFont systemFontOfSize:12.0f];
                            
                            cell.m_labelfield.text = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:[NSString stringWithFormat:@"%li",indexPath.row - 3]]];
                            cell.m_labelfield.tag = 1000 + (indexPath.row - 3);
                            
                        }
                        
                    }
                    
                    return cell;
                    
                }
                
            }else{
                
                if (indexPath.row == 0) {
                    
                    AddBCMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBCMenuTableViewCell"];
                    
                    if (!cell)
                    {
                        cell=[[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:0];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }
                    
                    cell.m_labelfield.delegate = self;
                    cell.m_btn.hidden = YES;
                    
                    
                    cell.m_labeltext.text = @"菜单";
                    cell.m_labelfield.placeholder = @"请输入菜单名称";
                    cell.m_labelfield.text = menunamestring;
                    cell.m_labelfield.tag = 201;
                    
                    cell.m_labelfield.font = [UIFont systemFontOfSize:14.0f];

                    
                    return cell;
                    
                }else if (indexPath.row == 1){
                    
                    HH_OrignCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HH_OrignCellIdentifier"];
                    
                    if (!cell)
                    {
                        cell=[[[NSBundle mainBundle]loadNibNamed:@"HH_CustomMenuCell" owner:self options:nil]objectAtIndex:3];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }
                    
                    cell.m_textField.delegate = self;

                    cell.m_textField.placeholder = @"请输入价格";
                    cell.m_textField.text = pricestring;
                    cell.m_textField.tag = 202;
                    
                    // 打开的时候表示参加会员卡活动
                    cell.m_titleLabel.text = @"不参加会员卡活动";
                    cell.m_switcher.tag = 1021;
                    
                    [cell.m_switcher setOn:NO];

                    [cell.m_switcher addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.m_switcher.frame = CGRectMake(WindowSizeWidth - 67, 6, cell.m_switcher.frame.size.width, cell.m_switcher.frame.size.height);

                    
                    return cell;
                    
                }
                else if (indexPath.row == 2){
                    
                    AddBCMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBCMenuTableViewCell"];
                    
                    if (!cell)
                    {
                        cell=[[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:0];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        
                    }
                    
                    cell.m_labelfield.delegate = self;
                    cell.m_btn.hidden = YES;
                    cell.m_labeltext.text = @"城与城价格";
                    cell.m_labelfield.placeholder = @"请输入价格";
                    
                    cell.m_labelfield.font = [UIFont systemFontOfSize:14.0f];
                    
                    cell.m_labelfield.text = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:@"20000"]];
                    cell.m_labelfield.tag = 20000;
                    
                    
                    return cell;
                    
                }
            }
            
        }else if ( indexPath.section == 3 ){
            
            if ( indexPath.row < 2 ) {
                
                AddBCMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBCMenuTableViewCell"];
                
                if (!cell)
                {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:0];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    
                }
                
                cell.m_labelfield.delegate = self;
                cell.m_btn.hidden = YES;
                
                if (indexPath.row == 0){
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    cell.m_labeltext.text = @"店铺";
                    cell.m_labelfield.placeholder = @"请选择店铺，支持多选";
                    cell.m_labelfield.text = shopnamestring;
                    cell.m_btn.hidden = NO;
                    [cell.m_btn addTarget:self action:@selector(Choseshop) forControlEvents:UIControlEventTouchUpInside];
                    cell.m_labelfield.enabled = NO;
                    
                }else if ( indexPath.row == 1 ){
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                    cell.m_labeltext.text = @"描述";
                    cell.m_labelfield.placeholder = @"请输入商品描述,可不填写";
                    cell.m_labelfield.delegate = self;
                    cell.m_labelfield.text = [NSString stringWithFormat:@"%@",description];
                    cell.m_labelfield.tag = 204;
                    
                }
                
                return cell;
                
                
            }else if ( indexPath.row == 2 ){
                
                AddBCMenuTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddBCMenuTableViewCell1"];
                
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"AddBCMenuTableViewCell" owner:self options:nil]objectAtIndex:1];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }
                
                [cell.m_imageview addTarget:self action:@selector(Chosephoto) forControlEvents:UIControlEventTouchUpInside];
                
                // 判断是新增还是编辑
                if ( [self.m_type isEqualToString:@"1"] ) {
                    
                    cell.m_imageview.hidden = NO;
                    cell.m_imageV.hidden = YES;
                    
                    if ([self.m_imagDic objectForKey:@"menuImage"]) {
                        
                        [cell.m_imageview setImage:[UIImage imageWithData:[self.m_imagDic objectForKey:@"menuImage"]] forState:UIControlStateNormal];
                        
                    }else{
                        
                        [cell.m_imageview setImage:[UIImage imageNamed:@"addicon.png"] forState:UIControlStateNormal];
                        
                    }
                    
                }else{
                    
                    if ( [self.m_isChange isEqualToString:@"0"] ) {
                        
                        cell.m_imageV.hidden = NO;
                        cell.m_imageview.hidden = NO;
                        cell.m_imageview.backgroundColor = [UIColor clearColor];
                        
                        NSString *imagePath = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MenuImage"]];
                        
                        [cell.m_imageview setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                        
                        // 表示直接赋值图片地址
                        [cell.m_imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                                             placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                          cell.m_imageV.image = image;
                                                      }
                                                      failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                          
                                                      }];
                        
                    }else if ( [self.m_isChange isEqualToString:@"1"] ){
                        
                        cell.m_imageV.hidden = YES;
                        cell.m_imageview.hidden = NO;
                        
                        // 表示直接赋值选择的图片
                        if ([self.m_imagDic objectForKey:@"menuImage"]) {
                            
                            [cell.m_imageview setImage:[UIImage imageWithData:[self.m_imagDic objectForKey:@"menuImage"]] forState:UIControlStateNormal];
                            
                        }else{
                            
                            [cell.m_imageview setImage:[UIImage imageNamed:@"addicon.png"] forState:UIControlStateNormal];
                            
                        }
                        
                    }
                    
                }
                
                return cell;
                
            }
        }
        
        return nil;
        
    }
    
    return nil;
    
}

- (void)requestLevelData {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberID",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [httpClient request:@"GetYongJinLevelList.ashx" parameters:param success:^(NSJSONSerialization *json) {
        
        self.levelArray = ((NSDictionary *)json)[@"YongJinigLevelList"];
        
    } failure:^(NSError *error) {
        
    }];

}

- (void)btnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    // 根据类型来判断选择是哪个
    if ( btn.tag == 111 ) {
        
        NSString *toShop = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOSHOPKEY]];
        
        if ( [toShop isEqualToString:@"1"] ) {
            
            [self.m_selectDic setObject:@"0" forKey:TOSHOPKEY];
            
            
        }else{
            
            [self.m_selectDic setObject:@"1" forKey:TOSHOPKEY];

        }
        
    }else if ( btn.tag == 222 ) {
        
        NSString *toHome = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOHOMEKEY]];
        
        if ( [toHome isEqualToString:@"1"] ) {
            
            [self.m_selectDic setObject:@"0" forKey:TOHOMEKEY];
            
            
        }else{
            
            [self.m_selectDic setObject:@"1" forKey:TOHOMEKEY];
            
        }
        
        
    }else{
        
        
    }
    
    
    // 刷新列表
    [self.ABCMTableview reloadData];
    
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        
        if ([isOpen isEqualToString:@"关闭"]) {
            
            LJNewCell *cell = [[LJNewCell alloc] init];
            
            return cell.height;
            
        }else {
        
            LJSettingCell *cell = [[LJSettingCell alloc] init];
            
            return cell.height;
            
        }
        
    }else if ( indexPath.section == 1 ) {
     
        if ( indexPath.row == 0 ) {
            
            if ( self.m_opend == 1 ) {
                
                return 44.0f + self.m_height;
                
            }else{
                
                return 44.0f;
                
            }
            
        }else if ( indexPath.row == 1 ){
            
            if ( self.m_buy == 1 ) {
                
                return 155.0f;
                
            }else{
                
                return 44.0f;
                
            }
            
        }else if ( indexPath.row == 2 ){
            
            return 44.0f;
            
        }else if ( indexPath.row == 3 ){
            
            return 80.0f;
            
        }else{
            
            return 50.0f;
        }
        
    }else if ( indexPath.section == 2 ){
        
        return 50.0f;
        
    }else if ( indexPath.section == 3 ){
        
        if ( indexPath.row == 2 ) {
            
            return 120.0f;
            
        }else{
            
            return 50.0f;
            
        }
        
    }else if ( indexPath.section == 4 ){
        
        return 60.0f;
    }

}

- (void)switchClicked:(id)sender{
    
    UISwitch *switcher = (UISwitch *)sender;
    
    if ( switcher.tag == 0 ) {
        
        // 是否对会员公开
        self.m_opend = !self.m_opend;
        
    }else if ( switcher.tag == 1 ){

        // 是否支持限制购买
        self.m_buy = !self.m_buy;

    }else if ( switcher.tag == 2 ){
        
        // 是否限制购买频率
        self.m_pinlv = !self.m_pinlv;
        
    }else if ( switcher.tag == 3 ){
        
        // 是否推荐到特价区
        self.m_tejia = !self.m_tejia;
        
    }else if ( switcher.tag == 1021 ){
        
        // 是否参加会员卡活动
        self.m_card = !self.m_card;
        
    }else if (switcher.tag == 999) {
    
        if ([isOpen isEqualToString:@"关闭"]) {
            
            isOpen = @"开启";
            
            isFuWuXiangMu = @"1";
            
        }else {
        
            isOpen = @"关闭";
            
            isFuWuXiangMu = @"0";
            
        }
    }
    
    // 刷新列表
    [self.ABCMTableview reloadData];
    
    
}


#define myDotNumbers     @"0123456789.\n"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  
    // 价格输入的时候进行判断
    if ( textField.tag == 202 || textField.tag >= 1000 ) {
        
        //输入字符限制
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (filtered.length == 0) {
            //支持删除键
            return [string isEqualToString:@""];
        }
        if (textField.text.length == 0) {
            return ![string isEqualToString:@"."];
        }
        //第一位为0，只能输入.
        else if (textField.text.length == 1){
            if ([textField.text isEqualToString:@"0"]) {
                return [string isEqualToString:@"."];
            }
        }
        else{//只能输入一个.
            if ([textField.text rangeOfString:@"."].length) {
                if ([string isEqualToString:@"."]) {
                    return NO;
                }
                //两位小数
                NSArray *ary =  [textField.text componentsSeparatedByString:@"."];
                if (ary.count == 2) {
                    if ([ary[1] length] == 2) {
                        return NO;
                    }
                }
            }
        }

    }
    
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    
    self.editingField = textField;
    
    if ( textField.tag == 101 || textField.tag == 102 || textField.tag == 33 || textField.tag == 44) {
        
        [self showNumPadDone:nil];
        
    }else{
        
        [self hiddenNumPadDone:nil];
        
        if (textField.tag == 204) {
            // 设置tableView滚动到第几行
            [self.ABCMTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
            [self.ABCMTableview setContentOffset:CGPointMake(0, 200)];
        }
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{

    if ( textField.tag == 101 ) {
        // 总份数
        totalUsedCount = textField.text;
        
    }else if ( textField.tag == 102 ){
        
        // 可用份数
        usedCount = textField.text;

        
    }else if ( textField.tag == 33 ){
        
        // 几天N份
        PinlvDay = textField.text;
        
        
    }else if ( textField.tag == 44 ){
        
        // N天几份
        usedCount = textField.text;
        
        
    }else if ( textField.tag == 201 ){
        
        // 菜单名称
        menunamestring = textField.text;
    
    }else if ( textField.tag == 202 ){
        
        // 原价
        pricestring = textField.text;
        
    }else if ( textField.tag == 203 ){
        
        // 打包费
        dabaofeiString = textField.text;
        
    }else if ( textField.tag == 204 ){
      
        // 描述
        description = textField.text;
        
    }else if ( textField.tag >= 1000&textField.tag<20000 ){
        
        // 会员卡的等级的价钱
        NSInteger index = textField.tag - 1000;
        
        [self.m_cardDic setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:[NSString stringWithFormat:@"%li",(long)index]];
        
        
    }else if ( textField.tag == 20000 ){
        
        // 城与城的价钱
        [self.m_cardDic setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:@"20000"];
        
        
    }else if (textField.tag == 808) {
    
        shiChang = textField.text;
        
    }else {
        
        for (int i = 0; i < self.levelArray.count; i ++) {
            
            NSDictionary *dic = self.levelArray[i];
            
            if (textField.tag == i) {
                
                NSDictionary *json = @{@"YongJinLevelID":dic[@"YongJinLevelID"],@"YongJinBiLi":textField.text};
                
                NSString *yjID = dic[@"YongJinLevelID"];
                
                if (mutAr.count == 0) {
                    
                    [mutAr addObject:json];
                    
                }else {
                    
                    for (int x = 0; x < mutAr.count; x ++) {
                        
                        NSDictionary *dict = mutAr[x];
                        
                        if ([dict[@"YongJinLevelID"] isEqualToString:yjID]) {
                            
                            [mutAr removeObject:dict];
                            
                        }
                        
                    }
                    
                    [mutAr addObject:json];
                    
                }
                
                countMutArr[i] = textField.text;
                
            }
 
        }
        
    }
  
}

//数组转Json
- (NSString *)arrayToJson:(NSArray *)array {
    
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (void)hideKeyboard{

//    [self.view endEditing:YES];
    
//    [self.editingField resignFirstResponder];
    
    [self.ABCMTableview endEditing:YES];
    
}

-(void)Choseshop
{
//    [self.view endEditing:YES];
    
//    [self.editingField resignFirstResponder];
    
    [self.ABCMTableview endEditing:YES];
    // 进入店铺选择的页面
    HH_shopListViewController *VC = [[HH_shopListViewController alloc]initWithNibName:@"HH_shopListViewController" bundle:nil];
    VC.delegate = self;
    VC.m_shopArray = self.m_shopList;
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - ShopListDelegate
- (void)getShopList:(NSMutableArray *)aShopArray{
    
    // 数组有值时将数据先清空
    if ( self.m_shopList.count != 0 ) {
        
        [self.m_shopList removeAllObjects];
    }
    // 添加到数组里
    [self.m_shopList addObjectsFromArray:aShopArray];
    
    if ( aShopArray.count != 0 ) {
        
        [self getShopId:aShopArray];
        
    }
}

// 赋值shopId和shopname
- (void)getShopId:(NSMutableArray *)arr{
    
    if ( arr.count != 0 ) {
        
        NSString *nameString = @"";
        
        NSString *shopIdString = @"";
        
        for (int i = 0; i < arr.count; i++) {
            
            NSDictionary *dic = [arr objectAtIndex:i];
            
            NSString *name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
            
            NSString *shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
            
            // 赋值
            if ( i != arr.count - 1 ) {
                
                nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@,",name]];
                
                shopIdString = [shopIdString stringByAppendingString:[NSString stringWithFormat:@"%@,",shopId]];
                
            }else{
                
                nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@",name]];
                
                shopIdString = [shopIdString stringByAppendingString:[NSString stringWithFormat:@"%@",shopId]];
                
            }
            
            shopnamestring = [NSString stringWithFormat:@"%@",nameString];
            
            shopIDstring = [NSString stringWithFormat:@"%@",shopIdString];
            
            
        }
        
    }else{
        
        shopnamestring = @"";
        shopIDstring = @"";
        
    }
    
    [self.ABCMTableview reloadData];
}

-(void)Chosephoto{
//    [self.view endEditing:YES];
    
//    [self.editingField resignFirstResponder];
    
    [self.ABCMTableview endEditing:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择封面"
                                              delegate:self
                                              cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照",@"从相册中选择", nil];
    actionSheet.tag = 1009;
    [actionSheet showInView:self.view];
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( actionSheet.tag == 1009 ) {
        
        if ( buttonIndex == 0 ) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            
            // 判断设备是否支持拍照
            if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
                
                [self alertWithMessage:@"本设备暂不支持拍照功能"];
                
            }else{
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.allowsEditing = YES;
                [self presentViewController:imagePicker animated:YES completion:nil];
                
            }
            
        }else if ( buttonIndex == 1 ){
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
    }
}

#pragma 拍照选择照片协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.m_isChange = @"1";
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *originImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
//        self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                          [self getImageData:originImage],@"menuImage",nil];
        
        [self.m_imagDic setValue:[self getImageData:originImage] forKey:@"menuImage"];
        
        [self.ABCMTableview reloadData];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSData *)getImageData:(UIImage *)image {
//    return UIImageJPEGRepresentation(image, 1);
    
     return UIImageJPEGRepresentation(image, 1);
    
}

- (void)saveMenuCilcked{
    
    yongJinBiLis = [self arrayToJson:mutAr];
    
//    [self.view endEditing:YES];
    
//    [self.editingField resignFirstResponder];
    
    [self.ABCMTableview endEditing:YES];
    
    // 是否限购
    if ( m_buy == 1 ) {
        
        if ( totalUsedCount.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写限制购买的总份数"];
            
            return;
        }
        
        if ( usedCount.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写限制购买的可使用份数"];
            
            return;
        }
        
    }
    if (m_pinlv == 1) {
        if ( PinlvDay.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写使用频率的天数"];
            
            return;
        }
        
        if ( usedCount.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写使用频率的份数"];
            
            return;
        }
    }
    
    if ([isOpen isEqualToString:@"开启"]) {
        
        if (yongJinBiLis.length == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写等级佣金比例"];
            
            return;
            
        }
        
        if (shiChang.length == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写项目时长"];
            
            return;
        }
    }
    
    // 打包费的判断
    NSString *toHome = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOHOMEKEY]];
    
    if ( [toHome isEqualToString:@"1"] ) {
        
        // 表示送货上门则要填写打包费
        if ( dabaofeiString.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写打包费"];
            
            return;
        }
        
    }

    // 菜单名称
    if ( menunamestring.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写菜单名称"];
        
        return;
        
    }
    
    // 原价
    if ( pricestring.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写菜单价格"];
        
        return;
        
    }
    
    // 是否参加活动进行判断
    if ( m_card == 1 ) {
        
        for (int i = 0; i < self.m_cardDic.count; i++) {
            
            NSString *string = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:[NSString stringWithFormat:@"%i",i]]];
            
            if ( string.length == 0 ) {
                
                [SVProgressHUD showErrorWithStatus:@"请输入会员等级对应的价格"];
                
                return;
                
            }
            
        }
        
    }
    
    
    NSString *ccstring = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:[NSString stringWithFormat:@"%i",20000]]];
        
        if ( ccstring.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入在城与城平台的价格"];
            
            return;
            
        }
        
    
    
    
    
    // 是否选择了店铺
    if ( shopIDstring.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择店铺"];
        
        return;
        
    }

    // 新增和编辑菜单时请求数据
    if ( [self.m_type isEqualToString:@"1"] ) {
        
        [self requestMenuSubmit];

    }else{
        
        [self editMenuRequestSubmit];
        
    }
    
}

- (void)requestMenuSubmit{
    
    NSLog(@"新增");
    
    // 是否对用户公开的值
    NSString *string = @"";
    
    if ( m_opend == 1 ) {
        
        if ( self.m_accountList.count != 0 ) {
            
            for ( int i = 0; i < self.m_accountList.count; i++) {
                
                
                // 赋值
                if ( i != self.m_accountList.count - 1 ) {
                    
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%@,",[self.m_accountList objectAtIndex:i]]];
                    
                }else{
                    
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%@",[self.m_accountList objectAtIndex:i]]];
                    
                }
            }
        }else{
            
            string = @"";
            
        }
        
    }else{
        
        string = @"";

    }
    
    // 使用份数
    NSString *totalString = @"";
    NSString *usedString = @"";
    
    if ( m_buy == 1 ) {
        
        totalString = [NSString stringWithFormat:@"%@",totalUsedCount];
        usedString = [NSString stringWithFormat:@"%@",usedCount];
        
    }else{
        
        totalString = @"";
        usedString = @"";
    }
    //使用频率
    NSString *m_pinlvDayString = @"";
    if (m_pinlv) {
        m_pinlvDayString = [NSString stringWithFormat:@"%@",PinlvDay];
    }

    // 送货上门打包费
    // 打包费的判断
    NSString *toHome = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOHOMEKEY]];
    NSString *toShop = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOSHOPKEY]];

    NSString *dabaofei = @"";
    
    if ( [toHome isEqualToString:@"1"] ) {
        
        dabaofei = [NSString stringWithFormat:@"%@",dabaofeiString];
        
    }else{
        
        dabaofei = @"";
        
    }
    
    
    // 是否参加活动进行判断
    NSString *cardPrice = @"";
//    （城与城价格）
    NSString *menuPriceCC = @"";
    
    if ( m_card == 1 ) {
        
        for ( int i = 0; i < self.m_starList.count; i ++) {
            
            NSString *price = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:[NSString stringWithFormat:@"%i",i]]];
            
            NSDictionary *dic = [self.m_starList objectAtIndex:i];
            
            NSString *gradeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VIPCardGradeID"]];
            
            NSString *string = [NSString stringWithFormat:@"%@,%@",gradeId,price];
            
            // 赋值
            if ( i != self.m_starList.count - 1 ) {
                
                cardPrice = [cardPrice stringByAppendingString:[NSString stringWithFormat:@"%@|",string]];
                
            }else{
                
                cardPrice = [cardPrice stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
                
            }
                        
        }
        
    }else{
        
        cardPrice = @"";

    }
    
    menuPriceCC = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:[NSString stringWithFormat:@"%i",20000]]];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",self.m_menuClassId],@"menuClassId",
                                  [NSString stringWithFormat:@"%@",menunamestring],@"menuName",
                                  [NSString stringWithFormat:@"%@",pricestring],@"menuPrice",
                                  [NSString stringWithFormat:@"%@",shopIDstring],@"merchantShopId",
                                  
                                  [NSString stringWithFormat:@"%i",m_opend],@"isInside",
                                  string,@"vipCardGradeID",
                                  [NSString stringWithFormat:@"%i",m_buy],@"isXG",
                                  totalString,@"xgAmountTotal",
                                  
                                  usedString,@"xgAmount",
                                  toShop,@"isDDXF",
                                  toHome,@"isHomeDelivery",
                                  dabaofei,@"PackingPrice",
                                  [NSString stringWithFormat:@"%i",m_card],@"isZCVIPCardGrade",
                                  cardPrice,@"menuPrices",
                                  [NSString stringWithFormat:@"%@",description],@"description",
                                  
                                  self.m_customMenuName,@"zdyParameter",
                                  menuPriceCC,@"menuPriceCC",
                                  [NSString stringWithFormat:@"%i",m_tejia],@"isZCTJ",
                                  [NSString stringWithFormat:@"%i",m_pinlv],@"isXZPL",
                                  [NSString stringWithFormat:@"%@",m_pinlvDayString],@"xzDays",
                                  
                                  isFuWuXiangMu,@"isFuWuXiangMu",
                                  shiChang,@"shiChang",
                                  yongJinBiLis,@"yongJinBiLis",

                                  nil];
    
    NSLog(@"参数：%@",param);
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient multiRequest:@"AddCloudMenu_4.ashx" parameters:param files:self.m_imagDic success:^(NSJSONSerialization* json){
        
        NSLog(@"111%@",(NSDictionary *)json);
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSLog(@"222%@",(NSDictionary *)json);
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [CommonUtil addValue:@"1" andKey:MenuListKey];
            
            
            [CommonUtil addValue:@"0" andKey:@"Custom_menu_Key"];
            
            
            // 过2s后返回上一个页面
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(lastView) userInfo:nil repeats:NO];
            
        } else {
            
            NSLog(@"333%@",(NSDictionary *)json);
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            [CommonUtil addValue:@"0" andKey:MenuListKey];
            
        }
    } failure:^(NSError *error) {
        
        NSLog(@"444");
        
        [CommonUtil addValue:@"0" andKey:MenuListKey];
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (void)editMenuRequestSubmit{
    
    if ([isFuWuXiangMu isEqualToString:@"0"]) {
        
        shiChang = @"";
        
        yongJinBiLis = @"";
        
    }
//    // 是否对用户公开的值
    NSString *string = @"";
    
    if ( m_opend == 1 ) {
        
        if ( self.m_accountList.count != 0 ) {
            
            for ( int i = 0; i < self.m_accountList.count; i++) {
                
                
                // 赋值
                if ( i != self.m_accountList.count - 1 ) {
                    
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%@,",[self.m_accountList objectAtIndex:i]]];
                    
                }else{
                    
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%@",[self.m_accountList objectAtIndex:i]]];
                    
                }
            }
        }else{
            
            string = @"";
            
        }
        
    }else{
        
        string = @"";
        
    }
    
    // 使用份数
    NSString *totalString = @"";
    NSString *usedString = @"";
    
    if ( m_buy == 1 ) {
        
        totalString = [NSString stringWithFormat:@"%@",totalUsedCount];
        usedString = [NSString stringWithFormat:@"%@",usedCount];
        
    }else{
        
        totalString = @"";
        usedString = @"";
    }
    
    //使用频率
    NSString *m_pinlvDayString = @"";
    if (m_pinlv) {
        m_pinlvDayString = [NSString stringWithFormat:@"%@",PinlvDay];
    }
    
    // 送货上门打包费
    // 打包费的判断
    NSString *toHome = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOHOMEKEY]];
    NSString *toShop = [NSString stringWithFormat:@"%@",[self.m_selectDic objectForKey:TOSHOPKEY]];
    
    NSString *dabaofei = @"";
    
    if ( [toHome isEqualToString:@"1"] ) {
        
        dabaofei = [NSString stringWithFormat:@"%@",dabaofeiString];
        
    }else{
        
        dabaofei = @"";
        
    }
    
    
    // 是否参加活动进行判断
    NSString *cardPrice = @"";
    //    （城与城价格）
    NSString *menuPriceCC = @"";
    
    if ( m_card == 1 ) {
        
        for ( int i = 0; i < self.m_starList.count; i ++) {
            
            NSString *price = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:[NSString stringWithFormat:@"%i",i]]];
            
            NSDictionary *dic = [self.m_starList objectAtIndex:i];
            
            NSString *gradeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VIPCardGradeID"]];
            
            NSString *string = [NSString stringWithFormat:@"%@,%@",gradeId,price];
            
            // 赋值
            if ( i != self.m_starList.count - 1 ) {
                
                cardPrice = [cardPrice stringByAppendingString:[NSString stringWithFormat:@"%@|",string]];
                
            }else{
                
                cardPrice = [cardPrice stringByAppendingString:[NSString stringWithFormat:@"%@",string]];
                
            }
            
            
            
        }
        
    }else{
        
        cardPrice = @"";

    }
    menuPriceCC = [NSString stringWithFormat:@"%@",[self.m_cardDic objectForKey:[NSString stringWithFormat:@"%i",20000]]];

    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    if ( [self.m_isChange isEqualToString:@"0"] ) {
        
        NSLog(@"1111111");
    
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      memberId,     @"memberId",
                                      key,   @"key",
                                      [NSString stringWithFormat:@"%@",menunamestring],@"menuName",
                                      [NSString stringWithFormat:@"%@",pricestring],@"menuPrice",
                                      [NSString stringWithFormat:@"%@",shopIDstring],@"merchantShopId",
                                      
                                      [NSString stringWithFormat:@"%i",m_opend],@"isInside",
                                      string,@"vipCardGradeID",
                                      [NSString stringWithFormat:@"%i",m_buy],@"isXG",
                                      totalString,@"xgAmountTotal",
                                      
                                      usedString,@"xgAmount",
                                      toShop,@"isDDXF",
                                      toHome,@"isHomeDelivery",
                                      dabaofei,@"PackingPrice",
                                      [NSString stringWithFormat:@"%i",m_card],@"isZCVIPCardGrade",
                                      cardPrice,@"menuPrices",
                                      [NSString stringWithFormat:@"%@",description],@"description",
                                      
                                      self.m_customMenuName,@"zdyParameter",
                                      
                                      [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CloudMenuID"]],@"cloudMenuID",
                                      self.m_isChange,@"isChange",
                                      
                                      [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MenuImage"]],@"menuImage",
                                      
                                      menuPriceCC,@"menuPriceCC",
                                      [NSString stringWithFormat:@"%i",m_tejia],@"isZCTJ",
                                      [NSString stringWithFormat:@"%i",m_pinlv],@"isXZPL",
                                      [NSString stringWithFormat:@"%@",m_pinlvDayString],@"xzDays",
                                      
                                      isFuWuXiangMu,@"isFuWuXiangMu",
                                      shiChang,@"shiChang",
                                      yongJinBiLis,@"yongJinBiLis",
                                      
                                      nil];
        
        NSLog(@"参数：%@",param);
        
        [httpClient request:@"EditCloudMenu_4.ashx" parameters:param success:^(NSJSONSerialization* json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                NSString *msg = [json valueForKey:@"msg"];
                
                NSLog(@"%@",msg);
                [SVProgressHUD showSuccessWithStatus:msg];
                
                [CommonUtil addValue:@"1" andKey:MenuListKey];
                
                // 过2s后返回上一个页面
                [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(lastView) userInfo:nil repeats:NO];
                
            } else {
                
                NSString *msg = [json valueForKey:@"msg"];

                [SVProgressHUD showErrorWithStatus:msg];
                
                [CommonUtil addValue:@"0" andKey:MenuListKey];
                
                NSLog(@"错误：：%@",msg);
                
            }
            
        } failure:^(NSError *error) {
            
            [CommonUtil addValue:@"0" andKey:MenuListKey];
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
            NSLog(@"错误：%@",[error localizedDescription]);
            
        }];
        
    }else if ( [self.m_isChange isEqualToString:@"1"] ) {
        
        NSLog(@"22222");
        
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      memberId,     @"memberId",
                                      key,   @"key",
                                      [NSString stringWithFormat:@"%@",menunamestring],@"menuName",
                                      [NSString stringWithFormat:@"%@",pricestring],@"menuPrice",
                                      [NSString stringWithFormat:@"%@",shopIDstring],@"merchantShopId",
                                      
                                      [NSString stringWithFormat:@"%i",m_opend],@"isInside",
                                      string,@"vipCardGradeID",
                                      [NSString stringWithFormat:@"%i",m_buy],@"isXG",
                                      totalString,@"xgAmountTotal",
                                      
                                      usedString,@"xgAmount",
                                      toShop,@"isDDXF",
                                      toHome,@"isHomeDelivery",
                                      dabaofei,@"PackingPrice",
                                      [NSString stringWithFormat:@"%i",m_card],@"isZCVIPCardGrade",
                                      cardPrice,@"menuPrices",
                                      [NSString stringWithFormat:@"%@",description],@"description",
                                      
                                      self.m_customMenuName,@"zdyParameter",
                                      
                                      [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CloudMenuID"]],@"cloudMenuID",
                                      self.m_isChange,@"isChange",
                                      menuPriceCC,@"menuPriceCC",
                                      
                                      isFuWuXiangMu,@"isFuWuXiangMu",
                                      shiChang,@"shiChang",
                                      yongJinBiLis,@"yongJinBiLis",
                                      
                                      nil];

        [httpClient multiRequest:@"EditCloudMenu_2.ashx" parameters:param files:self.m_imagDic success:^(NSJSONSerialization* json){
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
                
                [CommonUtil addValue:@"1" andKey:MenuListKey];
                
                // 过2s后返回上一个页面
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(lastView) userInfo:nil repeats:NO];
                
            } else {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
                
                [CommonUtil addValue:@"0" andKey:MenuListKey];
                
            }
        } failure:^(NSError *error) {
            
            [CommonUtil addValue:@"0" andKey:MenuListKey];
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }];
        
    }

 
    
    
}

- (void)lastView{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UINetWorking
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
    
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VIPCardGradeList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
            
            // 赋值
            self.m_starList = [json valueForKey:@"GradeList"];
            
            // 计算高度
            NSInteger count = self.m_starList.count % 3 == 0 ? self.m_starList.count / 3 : self.m_starList.count / 3 + 1;
            
            self.m_height = count * 40;
            
            // 1表示新增  2表示编辑
            if ( [self.m_type isEqualToString:@"1"] ) {
                
                
                // 默认为都没选中
                if ( self.m_starList.count != 0 ) {
                    
                    for (int i = 0; i < self.m_starList.count; i++) {
                        
                        // 将等级的id加入到数组里用于选择的时候用
                        NSDictionary *dic = [self.m_starList objectAtIndex:i];
                        
                        [self.m_accountList addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"VIPCardGradeID"]]];
                        
                        [self.m_openedDic setObject:@"1" forKey:[NSString stringWithFormat:@"%i",i]];
                        
                        // 支持会员卡活动时的字典的赋值
                        [self.m_cardDic setObject:@"" forKey:[NSString stringWithFormat:@"%i",i]];
                        
                    }
                }
                
            }else if ( [self.m_type isEqualToString:@"2"] ){
                
                NSMutableArray *arr = [self.m_dic objectForKey:@"GradePriceList"];

                NSMutableArray *gradeIdArr = [[NSMutableArray alloc]initWithCapacity:0];
                
                for (int i = 0; i < arr.count; i++) {
                    
                    NSDictionary *dic = [arr objectAtIndex:i];
                    
                    [gradeIdArr addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"VipCardGradeID"]]];
                    
                }
                
                
                // 默认为都没选中
                if ( self.m_starList.count != 0 ) {
                    
                    
                    NSString *VIPCardGradeID = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"VIPCardGradeID"]];
                    
                    NSArray *l_arr = [VIPCardGradeID componentsSeparatedByString:@","];
                    
                    for (int i = 0; i < self.m_starList.count; i++) {
                        
                        // 将等级的id加入到数组里用于选择的时候用
                        NSDictionary *dic = [self.m_starList objectAtIndex:i];
                        
                        // 判断对哪些用户进行公开
                        NSString *gradeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VIPCardGradeID"]];
                        
                        
                        if ( l_arr.count != 0 ) {
                            
                            if ( [l_arr containsObject:gradeId] ) {
                                
                                // 存放对公开用户的勾选状态
                                [self.m_openedDic setObject:@"1" forKey:[NSString stringWithFormat:@"%i",i]];
                                
                                // 存放对公开用户的等级id
                                [self.m_accountList addObject:gradeId];
                                
                                
                            }else{
                                
                                // 存放对公开用户的勾选状态
                                [self.m_openedDic setObject:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                                
                            }
                        }else{
                            
                            // 存放对公开用户的勾选状态
                            [self.m_openedDic setObject:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                            
                        }
                        
                        
                        // 判断每个会员等级对应的价格
                        
                        if ( [gradeIdArr containsObject:gradeId] ) {
                            
                            NSInteger index = [gradeIdArr indexOfObject:gradeId];
                            
                            NSDictionary *l_dic = [arr objectAtIndex:index];
                            
                            
                            // 支持会员卡活动时输入的值的字典的赋值
                            [self.m_cardDic setObject:[NSString stringWithFormat:@"%@",[l_dic objectForKey:@"GradePrice"]] forKey:[NSString stringWithFormat:@"%i",i]];

                        }else{
                            
                            // 支持会员卡活动时输入的值的字典的赋值
                            [self.m_cardDic setObject:@"" forKey:[NSString stringWithFormat:@"%i",i]];
                        }
                     
                    }
                }
                
            }
        
            // 刷新列表
            [self.ABCMTableview reloadData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self.view endEditing:YES];
    
    [self.ABCMTableview endEditing:YES];
    
//    [self.editingField resignFirstResponder];
   
}

@end
