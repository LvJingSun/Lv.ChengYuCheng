//
//  SC_productViewController.m
//  HuiHui
//
//  Created by mac on 14-11-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "SC_productViewController.h"

#import "HH_SearchViewController.h"

#import "TouchPropagatedScrollView.h"

#import "LocationCell.h"

#import "Configuration.h"

#import "QHCommonUtil.h"

#import "CommonUtil.h"

#import "LeftCell.h"

#import "MiddleCell.h"

#import "RightCell.h"

#import "ProductDetailViewController.h"

#import "HH_CateChooseViewController.h"


#define MENU_HEIGHT 40
#define MENU_BUTTON_WIDTH  60

#define MIN_MENU_FONT  13.f
#define MAX_MENU_FONT  13.f


#define VIEW_HEIGHT  40.f


typedef NS_ENUM(NSInteger, NJKScrollDirection) {
    NJKScrollDirectionNone,
    NJKScrollDirectionUp,
    NJKScrollDirectionDown,
};

NJKScrollDirection detectScrollDirection(currentOffsetY, previousOffsetY)
{
    return currentOffsetY > previousOffsetY ? NJKScrollDirectionUp   :
    currentOffsetY < previousOffsetY ? NJKScrollDirectionDown :
    NJKScrollDirectionNone;
}

@interface SC_productViewController (){
    
    TouchPropagatedScrollView *_navScrollV;

    float _startPointX;
    
    BOOL m_btnViewhidden;

}

@property (weak, nonatomic) IBOutlet UIView *m_view;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_categoryScroller;

@property (weak, nonatomic) IBOutlet UIView     *m_btnView;

@property (weak, nonatomic) IBOutlet UIButton   *m_allCategoryBtn;

@property (weak, nonatomic) IBOutlet UIButton   *m_diquBtn;

@property (weak, nonatomic) IBOutlet UIButton   *m_paixuBtn;

@property (weak, nonatomic) IBOutlet UIControl  *m_alphaView;

@property (weak, nonatomic) IBOutlet UILabel    *m_emptyLabel;

// 定义全局的UIImageView来判断滑动
@property (weak, nonatomic) UIImageView         *m_imageView;

@property (nonatomic) NJKScrollDirection    previousScrollDirection;
@property (nonatomic) CGFloat               previousOffsetY;
@property (nonatomic) CGFloat               accumulatedY;


// 搜索按钮触发的事件
- (IBAction)seachBtnClicked:(id)sender;

- (IBAction)addCategoryClicked:(id)sender;

// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint;

@end

@implementation SC_productViewController

@synthesize isFirst;

@synthesize m_CategoryArray;

@synthesize contentItems;

@synthesize TwoID;

@synthesize m_productList;

@synthesize m_dic;

@synthesize DPdealsarray;

@synthesize m_classList;

@synthesize m_categoryIndex;

//@synthesize m_testDic; 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        dbhelp = [[DBHelper alloc]init];
    
        isFirst = YES;
        
        m_CategoryArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        contentItems = [[NSMutableArray alloc]initWithCapacity:0];
        
        //产品
        self.LeftArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.MiddleArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.LeftArray2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.MiddleArray2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.RightArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.LeftArrayID = [[NSMutableArray alloc]initWithCapacity:0];
        self.MiddleArrayID = [[NSMutableArray alloc]initWithCapacity:0];
        self.LeftArrayID2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.MiddleArrayID2 = [[NSMutableArray alloc]initWithCapacity:0];
        
        [self.RightArray addObject:@"默认排序"];
        [self.RightArray addObject:@"销量最多"];
        [self.RightArray addObject:@"价格最高"];
        [self.RightArray addObject:@"价格最低"];
        [self.RightArray addObject:@"离我最近"];

        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        DPdealsarray = [[NSMutableArray alloc]initWithCapacity:0];
        
//        m_testDic = [[NSMutableDictionary alloc]initWithCapacity:0];

        m_classList = [[NSMutableArray alloc]initWithCapacity:0];
        
        
        searchHelper = [[SearchRecordsHelper alloc]init];
        
        isSelected = NO;

    }
    return self;
}

+ (SC_productViewController *)shareobject{
   
    static SC_productViewController *VC = nil;
   
    if ( VC == nil){
        
        VC = [[SC_productViewController alloc]init];
    }
    
    return VC;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    oldOffset = 0.0f;
    
    self.m_emptyLabel.hidden = YES;
    
    // 请求网络的两参数
    self.m_order = @"desc";
    self.m_sort = @"";

    m_pageIndex = 1;
    pageIndex = 1;
    
    
    // 设置scrollerView的属性
    self.m_scrollerView.backgroundColor = [UIColor clearColor];
    self.m_scrollerView.pagingEnabled = YES;
    self.m_scrollerView.showsVerticalScrollIndicator = NO;
    self.m_scrollerView.showsHorizontalScrollIndicator = NO;
    
    NSLog(@"WindowSize.size.height = %f",WindowSize.size.height);
    
    // 设置scrollerView的大小坐标
    if ( isIOS7 ) {
                
        [self.m_view setFrame:CGRectMake(0, 20, WindowSize.size.width, VIEW_HEIGHT)];
        
        [self.m_scrollerView setFrame:CGRectMake(0, 20 + VIEW_HEIGHT, WindowSize.size.width, WindowSize.size.height-20 - VIEW_HEIGHT - 30 - 49)];
        
        // 设置分类按钮及遮罩view的坐标
        [self.m_btnView setFrame:CGRectMake(0, self.m_scrollerView.frame.origin.y + self.m_scrollerView.frame.size.height, WindowSize.size.width, 30)];

        [self.m_alphaView setFrame:CGRectMake(0, self.m_view.frame.origin.y , WindowSize.size.width, self.m_btnView.frame.origin.y + self.m_btnView.frame.size.height + 150)];

        
    }else{
        
        // 不是ios7的情况下
        [self.m_view setFrame:CGRectMake(0, 0, WindowSize.size.width, VIEW_HEIGHT)];
        
        [self.m_scrollerView setFrame:CGRectMake(0, VIEW_HEIGHT, WindowSize.size.width, WindowSize.size.height - 20 - VIEW_HEIGHT - 30 - 49)];
        
        // 设置分类按钮及遮罩view的坐标
        [self.m_btnView setFrame:CGRectMake(0, self.m_scrollerView.frame.origin.y + self.m_scrollerView.frame.size.height, WindowSize.size.width, 30)];
        
        [self.m_alphaView setFrame:CGRectMake(0, self.m_view.frame.origin.y , WindowSize.size.width, self.m_btnView.frame.origin.y + self.m_btnView.frame.size.height + 150)];

    }
    
    // scrollerView添加的手势
    [self.m_scrollerView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    
    //默认不下拉
    leftOpened = middleOpened = leftOpened2 = middleOpened2 = rightOpened = NO;
    self.m_alphaView.alpha = 0;
    
    // 经纬度 ======
    NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
    NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
    
    NSString *cityId = [CommonUtil getValueByKey:kSelectCityId];
    
    self.m_latiString = [NSString stringWithFormat:@"%f",[latitudeString floatValue]];
    self.m_longtiString = [NSString stringWithFormat:@"%f",[lontiduteString floatValue]];
    
    selectCity = cityId;

  
    [self.m_allCategoryBtn addTarget:self action:@selector(MiddleOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_diquBtn addTarget:self action:@selector(LeftOpenBtn2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_paixuBtn addTarget:self action:@selector(RightOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置属性及请求数据
    [self setData];

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 添加往左滑返回的属性
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

//    [self hideTabBar:YES];
    
    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;

    
    leftOpened = NO;
    middleOpened = NO;
    leftOpened2 = NO;
    middleOpened2 = NO;
    rightOpened = NO;
    
    self.MiddleTableview.hidden = YES;
    self.LeftTableview2.hidden = YES;
    self.MiddleTableview2.hidden = YES;
    self.RightTableview.hidden = YES;
    
    CGRect frame = self.MiddleTableview.frame;
    //    frame.size.height = 0.0f;
    frame = CGRectMake(10, 479, 150, 0);
    [self.MiddleTableview setFrame:frame];
    

    CGRect frame2 = self.LeftTableview2.frame;
    //    frame2.size.height = 0.0f;
    frame2 = CGRectMake(10, 479, 150, 0);
    
    [self.LeftTableview2 setFrame:frame2];
    
    CGRect frame3 = self.MiddleTableview2.frame;
    //    frame3.size.height = 0.0f;
    frame3 = CGRectMake(160, 479, 150, 0);
    
    [self.MiddleTableview2 setFrame:frame3];
    
    CGRect frame4 = self.RightTableview.frame;
    //    frame4.size.height = 0.0f;
    frame4 = CGRectMake(160, 479, 150, 0);
    
    [self.RightTableview setFrame:frame4];
    
    self.m_alphaView.alpha = 0;
        
    // 根据BOOL值来判断是否要重新设置页面
    if ( isSelected ) {
        
        isSelected = NO;
        
        // 如果该值为NO，则表示更换了类别
        if ( !Appdelegate.m_isCategory ) {
            
            // 设置属性及请求数据
            [self setData];
            
            Appdelegate.m_isCategory = YES;
            
        }else{
            
            Appdelegate.m_isCategory = YES;
        }

    }else{
        
        // 判断是否是第一次进入该类
        if ( Appdelegate.m_isCategory ) {
            
            // 赋值 - 根据首页选择的类别来赋值
            NSDictionary *dic = [self.m_CategoryArray objectAtIndex:self.m_categoryIndex];
            [self.m_allCategoryBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] forState:UIControlStateNormal];
            
            m_index = self.m_categoryIndex;
            
            // 初始化scrollerView
            //        [self initScrollerView];
            
            //分类
            [self loadCategoryView];//加载一级类别
            //    [self FenleiDataTotableview2];//一级赋值
            
            //排序
            [self PaixuDataTotableview];//排序赋值
            
            //地区
            [self citySelectarea];//加载一级类别
            [self DiquDataTotableview1];//一级赋值
            [self.MiddleTableview2 reloadData];
            
            // 判断进来后如果数组没有值则去重新请求接口
            // 数组值为空的时候去请求数据
            NSMutableArray *arr = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",m_index]];
            
            if ( arr.count == 0 ) {
                
                // 请求数据
                [self requestProductList1];
                
            }

            //========
            
            // 根据选中的第几个来判断按钮的选中状态
            for (id btn in _navScrollV.subviews) {
                
                if ( [btn isKindOfClass:[UIButton class]] ) {
                    
                    UIButton *button = (UIButton *)btn;
                    
                    if( button.tag == self.m_categoryIndex + 1 )
                    {
                        [self changeColorForButton:btn red:1];
                        button.titleLabel.font = [UIFont systemFontOfSize:MAX_MENU_FONT];
                    }else
                    {
                        button.titleLabel.font = [UIFont systemFontOfSize:MIN_MENU_FONT];
                        [self changeColorForButton:btn red:0];
                    }
                    
                }
                
                
            }
            
            
            // 设置根据默认选中的第几个分类来判断scrollerView滚动到什么位置
            [self.m_scrollerView setContentOffset:CGPointMake(self.m_scrollerView.frame.size.width * self.m_categoryIndex, 0) animated:YES];
            
            // 计算上面分类scrollerView滚动的范围
            float xx = self.m_scrollerView.contentOffset.x * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
            [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
            
            // 设置滑块的滚动坐标
            [self moveImageMoveTo:xx + MENU_BUTTON_WIDTH];

        }else{
            
            Appdelegate.m_isCategory = YES;
            
        }
        
    }
  
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
 
//    [self hideTabBar:NO];
    
    // 显示导航栏
    self.navigationController.navigationBarHidden = NO;

    self.MiddleTableview.hidden = YES;
    self.LeftTableview2.hidden = YES;
    self.MiddleTableview2.hidden = YES;
    self.RightTableview.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置属性及请求数据
- (void)setData{
    m_index = 0;
    
    // 删除字典里的数据重新赋值
    if ( self.m_dic.count != 0 ) {
        
        [self.m_dic removeAllObjects];
    }
    
    // 从数据库中读取数据
    if ( [searchHelper categoryList].count != 0 ) {
        // 从数据库读取数据-已选择的类别数组
        self.m_CategoryArray = [searchHelper categoryList];
        
        if ( [searchHelper UncategoryList].count == 0 ) {
            
            // 已选的类别和所有的类别数组进行比较，取出没选中的数组存放到数据库中-表示所有类别的数组
            NSMutableArray *l_arr = [dbhelp queryCategory];
            
            for (int ii = 0; ii < self.m_CategoryArray.count; ii++) {
                
                NSDictionary *l_dic = [self.m_CategoryArray objectAtIndex:ii];
                
                NSString *string = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"name"]];
                
                // 两个数组进行比较，如果名称相同的话则删除，保留不相同的数据
                for (int i = 0;i < [l_arr count]; i++) {
                    
                    NSDictionary *dic = [l_arr objectAtIndex:i];
                    
                    NSString *string111 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
                    
                    if ( [string isEqualToString:string111] ) {
                        
                        
                        [l_arr removeObjectAtIndex:i];
                        
                        break;
                        
                    }
                }
                
            }
            
            // 将数组存放到数据库中
            [searchHelper updateUncategoryList:l_arr];
        }
        
        self.m_classList = [searchHelper UncategoryList];
    }
    
    
    // 赋值 - 根据首页选择的类别来赋值
    NSDictionary *dic = [self.m_CategoryArray objectAtIndex:self.m_categoryIndex];
    [self.m_allCategoryBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] forState:UIControlStateNormal];
    
    m_index = self.m_categoryIndex;
    
    // 初始化scrollerView
    [self initScrollerView];
    
    //分类
    [self loadCategoryView];//加载一级类别
    //    [self FenleiDataTotableview2];//一级赋值
    
    //排序
    [self PaixuDataTotableview];//排序赋值
    
    //地区
    [self citySelectarea];//加载一级类别
    [self DiquDataTotableview1];//一级赋值
    [self.MiddleTableview2 reloadData];
    
    // 请求商品数据
    [self requestProductList1];
    
}

- (IBAction)seachBtnClicked:(id)sender{
    
    // 设置为NO后返回不执行任何操作
    Appdelegate.m_isCategory = NO;

    
    // test 进入搜索的页面
    HH_SearchViewController *VC = [[HH_SearchViewController alloc]initWithNibName:@"HH_SearchViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];

}

- (IBAction)addCategoryClicked:(id)sender {
    
     isSelected = YES;
    
//    [SVProgressHUD showErrorWithStatus:@"栏目选择"];
    
    // 进入分类选择的页面
    HH_CateChooseViewController *VC = [[HH_CateChooseViewController alloc]initWithNibName:@"HH_CateChooseViewController" bundle:nil];
    VC.m_haderList = self.m_CategoryArray;
    VC.m_categoryList = [searchHelper UncategoryList];
    [self.navigationController pushViewController:VC animated:YES];
    
}

// 初始化scrollerView及tableView
- (void)initScrollerView{
    
    for (id view in self.m_view.subviews) {
        
        if ( [view isKindOfClass:[TouchPropagatedScrollView class]] ) {
            
            [view removeFromSuperview];
            
        }
        
    }

    float btnW = 30;
    
    _navScrollV = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - btnW - 7 - 30, MENU_HEIGHT)];
    
    _navScrollV.backgroundColor = [UIColor clearColor];
        
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    
    for (int i = 0; i < [self.m_CategoryArray count]; i++)
    {
        NSDictionary *dic = [self.m_CategoryArray objectAtIndex:i];
        
        NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];

        // 根据名称的内容来计算btn的宽度
//        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 30) lineBreakMode:NSLineBreakByCharWrapping];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(MENU_BUTTON_WIDTH * i, 0, MENU_BUTTON_WIDTH, MENU_HEIGHT)];
//        btn.frame = CGRectMake(sum + 10, -15, size.width + 10, 30);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:[NSString stringWithFormat:@"%@",string] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
      
        if( i == self.m_categoryIndex )
        {
            [self changeColorForButton:btn red:1];
            btn.titleLabel.font = [UIFont systemFontOfSize:MAX_MENU_FONT];
        }else
        {
            btn.titleLabel.font = [UIFont systemFontOfSize:MIN_MENU_FONT];
            [self changeColorForButton:btn red:0];
        }
        [btn addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navScrollV addSubview:btn];
    }
    
    // 添加线条标志滑动 =========
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 38, MENU_BUTTON_WIDTH, 2)];
    imageView.backgroundColor = [UIColor redColor];
    
    self.m_imageView = imageView;
    
    [_navScrollV addSubview:self.m_imageView];
    //===========
    
    // 设置scrollerView的滚动范围
    [_navScrollV setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * [self.m_CategoryArray count], MENU_HEIGHT)];

    [self.m_view addSubview:_navScrollV];

    [self addView2Page:self.m_scrollerView count:[self.m_CategoryArray count] frame:CGRectZero];
    
    
}

- (void)changeColorForButton:(UIButton *)btn red:(float)nRedPercent
{
    float value = [QHCommonUtil lerp:nRedPercent min:0 max:212];
    [btn setTitleColor:RGBA(value,25,38,1) forState:UIControlStateNormal];
}


#pragma mark - action
- (void)actionbtn:(UIButton *)btn
{
    
    pageIndex = 1;
    m_pageIndex = 1;
    
//    DP_pageIndex = 1;

    m_index = btn.tag - 1;
    
    [self.m_scrollerView scrollRectToVisible:CGRectMake(self.m_scrollerView.frame.size.width * (btn.tag - 1), self.m_scrollerView.frame.origin.y, self.m_scrollerView.frame.size.width, self.m_scrollerView.frame.size.height) animated:YES];
    
    float xx = self.m_scrollerView.frame.size.width * (btn.tag - 1) * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
    // 设置滑块的滚动坐标
    [self moveImageMoveTo:xx + MENU_BUTTON_WIDTH];
    
    [self changeView:0.0f];

    NSMutableArray *arr = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",m_index]];

    NSLog(@"arr111 = %@",arr);
    
    // 数组值为空的时候去请求数据
    if ( arr.count == 0 ) {
    
        // 请求数据
        [self requestProductList1];

    }else if ( arr.count == 1 ){
        
        NSMutableArray *l_arr = [arr objectAtIndex:0];
                
        if ( l_arr.count == 0 ) {
            
            self.m_emptyLabel.hidden = NO;
       
        }else{
            
            self.m_emptyLabel.hidden = YES;

        }
        
    }else{

        self.m_emptyLabel.hidden = YES;

    }

}

- (void)addView2Page:(UIScrollView *)scrollV count:(NSUInteger)pageCount frame:(CGRect)frame
{
    // 先清空数据再重新赋值
    for (id view in scrollV.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    if ( self.contentItems.count != 0 ) {
        
        [self.contentItems removeAllObjects];
    }
    
    for (int i = 0; i < pageCount; i++)
    {
        // 添加tableView到scrollerView上面
        PullTableView *tableView = [[PullTableView alloc]initWithFrame:CGRectMake(scrollV.frame.size.width * i, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
        
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [tableView setPullDelegate:self];
        tableView.pullBackgroundColor = [UIColor whiteColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.useRefreshView = YES;
        tableView.useLoadingMoreView = YES;
        tableView.tag = i;
        tableView.hidden = YES;
        [scrollV addSubview:tableView];
        
        [contentItems addObject:tableView];
    }
    
    [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width * pageCount, scrollV.frame.size.height)];

    // 设置根据默认选中的第几个分类来判断scrollerView滚动到什么位置
    [scrollV setContentOffset:CGPointMake(scrollV.frame.size.width * self.m_categoryIndex, 0) animated:YES];
    
    // 计算上面分类scrollerView滚动的范围
    float xx = scrollV.contentOffset.x * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
    
    // 设置滑块的滚动坐标
    [self moveImageMoveTo:xx + MENU_BUTTON_WIDTH];

    
}

// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint
{
    [UIView beginAnimations:@"Flips1" context:(__bridge void *)(self)];
    [UIView setAnimationDuration:0.3];
    self.m_imageView.frame = CGRectMake(rectPoint, 38, self.m_imageView.frame.size.width, self.m_imageView.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ( scrollView == self.m_scrollerView ) {
    
        _startPointX = scrollView.contentOffset.x;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ( scrollView == self.m_scrollerView ) {
        
        pageIndex = 1;
        
        m_pageIndex = 1;
        
        [self changeView:scrollView.contentOffset.x];
    
    }else{
        
        if (!ended) {
            return;
        }
        
        // 判断tableView是上滑还是下滑
        CGFloat currentOffsetY = scrollView.contentOffset.y;
        
        
        NJKScrollDirection currentScrollDirection = detectScrollDirection(currentOffsetY, _previousOffsetY);
        
        CGFloat topBoundary = -scrollView.contentInset.top;
        CGFloat bottomBoundary = scrollView.contentSize.height + scrollView.contentInset.bottom;

        BOOL isOverTopBoundary = currentOffsetY <= topBoundary;
        BOOL isOverBottomBoundary = currentOffsetY >= bottomBoundary;
        
        BOOL isBouncing = (isOverTopBoundary && currentScrollDirection != NJKScrollDirectionDown) || (isOverBottomBoundary && currentScrollDirection != NJKScrollDirectionUp);
        if (isBouncing || !scrollView.isDragging) {
            return;
        }
        
        CGFloat deltaY = _previousOffsetY - currentOffsetY;
        _accumulatedY += deltaY;
  
        switch (currentScrollDirection) {
            case NJKScrollDirectionUp:
            {
                BOOL isOverThreshold = _accumulatedY < -_upThresholdY;

                if (isOverThreshold || isOverBottomBoundary)  {
                    
                    [self scrollFullScreenScrollViewDidScrollUp:deltaY];
                }
            }
                break;
            case NJKScrollDirectionDown:
            {
                BOOL isOverThreshold = _accumulatedY > _downThresholdY;
                
                if (currentOffsetY + WindowSize.size.height - scrollView.contentSize.height >30) {
                    
                    [self scrollFullScreenScrollViewDidScrollUp:deltaY];

                }else if (isOverThreshold || isOverTopBoundary) {
                    
                    [self scrollFullScreenScrollViewDidScrollDown:deltaY];
                }
            }
                break;
            case NJKScrollDirectionNone:
                break;
        }
        
        // reset acuumulated y when move opposite direction
        if (!isOverTopBoundary && !isOverBottomBoundary && _previousScrollDirection != currentScrollDirection) {
            _accumulatedY = 0;
        }
        
        _previousScrollDirection = currentScrollDirection;
        _previousOffsetY = currentOffsetY;

    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    ended = YES;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    if ( scrollView == self.m_scrollerView ) {

        // 计算上面分类scrollerView滚动的范围
        float xx = scrollView.contentOffset.x * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
        [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
        
        // 设置滑块的滚动坐标
        [self moveImageMoveTo:xx + MENU_BUTTON_WIDTH];
        
        int page = scrollView.contentOffset.x /320;
        
        m_index = page;
    
        [self changeView:scrollView.contentOffset.x];
        
        NSMutableArray *arr = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",m_index]];
                
        // 数组值为空的时候去请求数据
        if ( arr.count == 0 ) {
            
            // 请求数据
            [self requestProductList1];
            
        }else if ( arr.count == 1 ){
            
            NSMutableArray *l_arr = [arr objectAtIndex:0];
            
            if ( l_arr.count == 0 ) {
                
                self.m_emptyLabel.hidden = NO;
                
            }else{
                
                self.m_emptyLabel.hidden = YES;
                
            }
            
        }else{
            
            self.m_emptyLabel.hidden = YES;
            
        }

    }
    
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    if (currentOffsetY + WindowSize.size.height - scrollView.contentSize.height >30) {
        return;
    }
    if ( m_btnViewhidden ) {
        
        [self moveViewDown:0 animated:YES];
        
    }
    ended = YES;

}



#pragma mark -
#pragma mark NJKScrollFullScreenDelegate
- (void)scrollFullScreenScrollViewDidScrollUp:(CGFloat)deltaY
{
 
    [self moveView:deltaY animated:YES];
    
}

- (void)scrollFullScreenScrollViewDidScrollDown:(CGFloat)deltaY
{


   [self moveViewDown:deltaY animated:YES];

    
}



- (void)moveView:(CGFloat)deltaY animated:(BOOL)animated{
    
    if ( isIOS7 ) {
        
        [self.m_scrollerView setFrame:CGRectMake(0, 20 + VIEW_HEIGHT, WindowSize.size.width, WindowSize.size.height-20 - VIEW_HEIGHT - 49)];
        
    }else{
        
        // 不是ios7的情况下
        [self.m_scrollerView setFrame:CGRectMake(0, VIEW_HEIGHT, WindowSize.size.width, WindowSize.size.height - 20 - VIEW_HEIGHT - 49)];
        
    }
    // 设置view的坐标
    [UIView animateWithDuration:0.3 animations:^{
        
        if ( !m_btnViewhidden ) {
            
//            self.m_btnView.hidden = YES;
            m_btnViewhidden = YES;
            
            CGSize size = CGSizeMake( WindowSize.size.width, WindowSize.size.height - 20 - VIEW_HEIGHT - 49);
            
            if ( isIOS7 ) {

                // 设置分类按钮及遮罩view的坐标
                [self.m_btnView setFrame:CGRectMake(0, 20 + VIEW_HEIGHT + size.height + 30, WindowSize.size.width, 30)];
                
                
            }else{
                 // 设置分类按钮及遮罩view的坐标
                [self.m_btnView setFrame:CGRectMake(0, VIEW_HEIGHT + size.height+ 30, WindowSize.size.width, 30)];
                
                
            }
          
            
        }
        
    } completion:^(BOOL finished) {
        

        
        for (id tableView in self.m_scrollerView.subviews) {
            
            if ( [tableView isKindOfClass:[PullTableView class]] ) {
                
                PullTableView *table = (PullTableView *)tableView;
                table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, WindowSize.size.width, self.m_scrollerView.frame.size.height);
                
            }
            
        }
    }];
    
}

- (void)moveViewDown:(CGFloat)deltaY animated:(BOOL)animated{
    
    [UIView animateWithDuration:0.3 animations:^{

        if ( m_btnViewhidden ) {
            
            m_btnViewhidden = NO;
            
            CGSize size = CGSizeMake(WindowSize.size.width, WindowSize.size.height-20 - VIEW_HEIGHT - 30 - 49);
            
            if ( isIOS7 ) {

                // 设置分类按钮及遮罩view的坐标
                [self.m_btnView setFrame:CGRectMake(0, 20 + VIEW_HEIGHT + size.height, WindowSize.size.width, 30)];
                
                
            }else{

                // 设置分类按钮及遮罩view的坐标
                [self.m_btnView setFrame:CGRectMake(0, VIEW_HEIGHT + size.height, WindowSize.size.width, 30)];
                
            }
            
        }
        
        
    } completion:^(BOOL finished) {
        
        for (id tableView in self.m_scrollerView.subviews) {
            
            if ( [tableView isKindOfClass:[PullTableView class]] ) {
                
                PullTableView *table = (PullTableView *)tableView;
                table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, WindowSize.size.width, self.m_scrollerView.frame.size.height);
                
                
            }
            
        }

    }];


}


#pragma mark - ChangeView
- (void)changeView:(float)x
{
     // 设置btn的按钮的颜色
    for (id btn in _navScrollV.subviews) {
        if ( [btn isKindOfClass:[UIButton class]] ) {
            
            UIButton *l_btn = (UIButton *)btn;
            
            if( l_btn.tag == m_index + 1 )
            {
                [self changeColorForButton:l_btn red:1];
                l_btn.titleLabel.font = [UIFont systemFontOfSize:MAX_MENU_FONT];
                // 选中的当前按钮不可再点击
                l_btn.userInteractionEnabled = NO;
                
                
            }else
            {
                l_btn.titleLabel.font = [UIFont systemFontOfSize:MIN_MENU_FONT];
                [self changeColorForButton:l_btn red:0];
                // 未选中的当前按钮可再点击
                l_btn.userInteractionEnabled = YES;

            }
        }
    }
    
    NeedOpenTwo = @"NeedOpenTwo";
    
    NSDictionary *dic = [self.m_CategoryArray objectAtIndex:m_index];
    // 设置btn的
    [self.m_allCategoryBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]forState:UIControlStateNormal];
    
    OneID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
    
    // 赋值 - 分类首次默认为全部
    TwoID = OneID;
    
    [self categorySelect];
    
    [self FenleiDataTotableview2];
    
    [self.MiddleTableview reloadData];

}

- (void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    BOOL isPaning = NO;
    
    if(self.m_scrollerView.contentOffset.x < 0)
    {
        isPaning = YES;
       
    }
    
    // 滚动scrollerView，返回上一级
    if(isPaning)
    {
        
        [self goBack];
    }
}

#pragma mark - UItableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *l_arr = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",m_index]];
    
    if ( l_arr.count != 0 && l_arr.count == 2 ) {
        
        NSMutableArray *arr = [l_arr objectAtIndex:0];
        
        NSMutableArray *dpArr = [l_arr objectAtIndex:1];
        
        return  arr.count + dpArr.count;
        
    }else{
        
        return 0;
    }
 
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PullTableView *l_tableView = (PullTableView *)[contentItems objectAtIndex:m_index];
    
    if ( tableView == l_tableView ) {
        
        static NSString *cellIdentifier = @"LocationCellIdentifier";
        
        LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LocationCell" owner:self options:nil];
            
            cell = (LocationCell *)[nib objectAtIndex:0];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        
        NSMutableArray *l_arr = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",m_index]];
        
        if ( l_arr.count != 0 ) {
            
            cell.hidden = NO;
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            if ( l_arr.count != 0 && l_arr.count == 2 ) {
                
                NSMutableArray *arr = [l_arr objectAtIndex:0];
                
                NSMutableArray *dpArr = [l_arr objectAtIndex:1];
                
                if ( arr.count != 0 || dpArr.count != 0 ) {
                    
                    if ( indexPath.row < arr.count ) {
                        
                        dic = [arr objectAtIndex:indexPath.row];
                        
                        
                        // 设置图片
                        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ApplePoster315"]]];
                        // 设置cell上面的评分
                        [cell setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Rank"]]];
                        
                        // 赋值
                        cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
                        cell.m_infoLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Detail"]];
                        cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
                        cell.m_orignLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"OriginalPrice"]];
                        
                        // 计算label的大小坐标
                        CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        
                        cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
                        
                        cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 5, cell.m_orignLabel.frame.origin.y, size1.width + 2, 21);
                        
                        cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 7, cell.m_lineLabel.frame.origin.y, size1.width + 3, 1);
                        
                        cell.m_distanceLabel.hidden = YES;
                        
                    }else if ( indexPath.row >= arr.count ){
                        
                        //大众点评列表数据
                        dic = [dpArr objectAtIndex:indexPath.row - arr.count];
                        
                        // 设置图片
                        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"s_image_url"]]];
                        // 设置cell上面的评分
                        [cell setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"0"]]];
                        
                        // 赋值
                        cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
                        cell.m_infoLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]];
                        cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"current_price"]];
                        cell.m_orignLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"list_price"]];
                        
                        // 计算label的大小坐标
                        CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        
                        cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
                        
                        cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 5, cell.m_orignLabel.frame.origin.y, size1.width + 2, 21);
                        
                        cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 7, cell.m_lineLabel.frame.origin.y, size1.width + 3, 1);
                        
                        cell.m_distanceLabel.hidden = NO;
                        if ([[dic objectForKey:@"distance"] intValue]>=1000) {
                            cell.m_distanceLabel.text = [NSString stringWithFormat:@"%@km",[NSString stringWithFormat:@"%.1f",[[dic objectForKey:@"distance"] floatValue]/1000]];
                        }else{
                            //返回 m
                            cell.m_distanceLabel.text = [NSString stringWithFormat:@"%@米",[dic objectForKey:@"distance"]];
                        }
                        
                    }else{
                        
                        
                    }
                    
                }

                
            }else{
                
                
            }
           
        }else{
            
            cell.hidden = YES;
            
        }
        
        return cell;

    }else{
        
        return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    
}

#pragma mark - UITableViewDegelate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 100.0f;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
  
    // 设置为NO后返回不执行任何操作
    Appdelegate.m_isCategory = NO;
 
    
    NSMutableArray *arr = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",m_index]];
    
    if ( arr.count != 0 ) {
        
        NSMutableArray *l_arr = [arr objectAtIndex:0];
        NSMutableArray *dpArr = [arr objectAtIndex:1];
        
        //大众点评数据
        if ( indexPath.row >= l_arr.count ) {
            
            NSMutableDictionary *dic = [dpArr objectAtIndex:indexPath.row - l_arr.count];
            
            // 将商品的图片保存起来用于立即购买页面的显示
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"s_image_url"]] andKey:@"productImage"];
            
            // 点击进入商品详情
            ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
            
            VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"deal_id"]];
            VC.m_FromDPId  =@"1";
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            
            NSMutableDictionary *dic = [l_arr objectAtIndex:indexPath.row];
            
            // 将商品的图片保存起来用于立即购买页面的显示
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ApplePoster315"]] andKey:@"productImage"];
            
            // 点击进入商品详情
            ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
            
            VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
            VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

#pragma mark - 分类tableView
//加载类别一
-(void)loadCategoryView
{
//    NSMutableArray *categorys = [dbhelp queryCategory];
  
    [self loadcelldata:self.m_CategoryArray];
}
//二
- (void)categorySelect {
    
    NSMutableArray *areas = [dbhelp queryProject:[NSString stringWithFormat:@"%@",OneID]];
    
    [self loadcelldatatwo:areas];
}

-(void)loadcelldata:(NSArray*)datalist
{
    
    [self.LeftArray removeAllObjects];
    [self.LeftArrayID removeAllObjects];
    
    if (datalist == nil) {
        return;
    }
//    [self.LeftArray addObject:@"全部分类"];
//    [self.LeftArrayID addObject:@""];
   
    for (NSDictionary *data in datalist)
    {
        [self.LeftArray addObject:[data objectForKey:@"name"]];
        
        [self.LeftArrayID addObject:[data objectForKey:@"code"]];
    }
    
    
    // 加载完第一级的数据后加载第二级的数据
    NeedOpenTwo = @"NeedOpenTwo";
    
    OneID = [NSString stringWithFormat:@"%@",[self.LeftArrayID objectAtIndex:self.m_categoryIndex]];
   
    // 赋值，表示刚开始的时候是全部某个分类
    TwoID = OneID;
    
    [self categorySelect];
    
    [self FenleiDataTotableview2];
    
    [self.MiddleTableview reloadData];
    
    middleOpened = NO;
    
}

-(void)loadcelldatatwo:(NSArray*)datalist
{
    [self.MiddleArray removeAllObjects];
    [self.MiddleArrayID removeAllObjects];
    if (datalist == nil) {
        return;
    }
    [self.MiddleArray addObject:@"全部"];
    [self.MiddleArrayID addObject:@""];
    for (NSDictionary *data in datalist)
    {
        [self.MiddleArray addObject:[data objectForKey:@"name"]];
        
        [self.MiddleArrayID addObject:[data objectForKey:@"code"]];
    }
}

- (void)citySelectarea
{
    
    NSMutableArray *areas = [dbhelp queryArea:selectCity];
    
    [self loadcelldata2:areas];
    
}

- (void)areaSelectmerchant
{
    
    NSMutableArray *areas = [dbhelp queryMerchant:OneID2];
    
    [self loadcelldatatwo2:areas];
}

- (void)loadcelldata2:(NSArray*)datalist
{
    [self.LeftArray2 removeAllObjects];
    [self.LeftArrayID2 removeAllObjects];
    
    if (datalist == nil) {
        return;
    }
    [self.LeftArray2 addObject:@"全城"];
    [self.LeftArrayID2 addObject:@""];
    
    for (NSDictionary *data in datalist)
    {
        [self.LeftArray2 addObject:[data objectForKey:@"name"]];
        
        [self.LeftArrayID2 addObject:[data objectForKey:@"code"]];
    }
    
}

- (void)loadcelldatatwo2:(NSArray*)datalist
{
    [self.MiddleArray2 removeAllObjects];
    [self.MiddleArrayID2 removeAllObjects];
    if (datalist == nil) {
        return;
    }
    [self.MiddleArray2 addObject:@"全部"];
    [self.MiddleArrayID2 addObject:@""];
    for (NSDictionary *data in datalist)
    {
        [self.MiddleArray2 addObject:[data objectForKey:@"name"]];
        
        [self.MiddleArrayID2 addObject:[data objectForKey:@"code"]];
    }
}

#pragma mark - 产品
//分类一赋值tableview
/*-(void) FenleiDataTotableview1
{
    
    [self.LeftTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.LeftArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         LeftCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
         
         if (!cell)
             
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"LeftCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
             
             if (indexPath.row == 0) {
             }else{
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
             }
         }
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.LeftArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         if (indexPath.row == 0) {
             
             NeedOpenTwo = @"";
             [self.m_fenleiBtn setTitle:@"全部分类" forState:UIControlStateNormal];
             
             OneID = TwoID = @"";
             
             pageIndex=1;
             m_pageIndex = 1;
             
             //请求产品列表
             self.m_searchBar.text = @"";
             
             // 如果是全部、全城、离我最近，则请求商户分类的显示
             if ( OneID2.length == 0 && self.m_string.length != 0 ) {
                 
                 self.isNearestForMe = YES;
                 
             }else{
                 
                 self.isNearestForMe = NO;
                 
             }
             
             if ( self.isNearestForMe ) {
                 
                 [self merchantAndProductRequest];
                 
             }else{
                 
                 [self requestProductList1];
                 
             }
             [self alphaviewtap:nil];
             
         }else{
             
             self.isNearestForMe = NO;
             
             NeedOpenTwo = @"NeedOpenTwo";
             
             OneID = [NSString stringWithFormat:@"%@",[self.LeftArrayID objectAtIndex:indexPath.row]];
             
             [self categorySelect];
             
             [self FenleiDataTotableview2];
             
             [self.MiddleTableview reloadData];
             
             middleOpened = NO;
             
             [self MiddleOpenBtn];
         }
         
     }];
    
    [self.LeftTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.LeftTableview.layer setBorderWidth:0];
    
}*/

//分类二赋值
-(void) FenleiDataTotableview2
{
    
    [self.MiddleTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.MiddleArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.MiddleArray objectAtIndex:indexPath.row]]];
         
         return cell;
     
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = (RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if (indexPath.row == 0) {
             
             for (int i=0; i<self.LeftArrayID.count; i++) {
                 
                 if ([OneID isEqualToString:[self.LeftArrayID objectAtIndex:i]]) {
                     
                     //类别就传一级ID
                     TwoID = OneID;

                     [self.m_allCategoryBtn setTitle:[self.LeftArray objectAtIndex:i] forState:UIControlStateNormal];
                     
                     break;
                 }
                 
             }
             
             
             
         }else{
             
             [self.m_allCategoryBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
             
             TwoID = [NSString stringWithFormat:@"%@",[self.MiddleArrayID objectAtIndex:indexPath.row]];
             
         }
    

        pageIndex = 1;
         
         m_pageIndex = 1;
         
         //请求产品列表
         [self requestProductList1];
         
         
         [self alphaviewtap:nil];
         
     }];
    
    
    
    [self.MiddleTableview .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.MiddleTableview .layer setBorderWidth:0];
    
    
    
}

//地区一赋值
-(void) DiquDataTotableview1
{
    
    [self.LeftTableview2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.LeftArray2.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         LeftCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
         
         if (!cell)
             
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"LeftCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
             
             if (indexPath.row == 0) {
             }else{
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
             }
         }
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.LeftArray2 objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         //        LeftCell *cell=(LeftCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if (indexPath.row ==0) {
             
             NeedOpenTwo2 = @"";
             [self.m_diquBtn setTitle:@"全城" forState:UIControlStateNormal];
             
             OneID2 = TwoID2 = @"";
             
             pageIndex=1;
             m_pageIndex = 1;
             
//             self.m_searchBar.text = @"";
             
             // 如果是全部、全城、离我最近，则请求商户分类的显示
//             if ( TwoID.length == 0 && self.m_string.length != 0 ) {
//                 
//                 self.isNearestForMe = YES;
//                 
//             }else{
//                 
//                 self.isNearestForMe = NO;
//                 
//             }
             
             //请求产品列表
//             if ( self.isNearestForMe ) {
//                 
//                 [self merchantAndProductRequest];
//                 
//             }else{
             
                 [self requestProductList1];
                 
//             }
         
             [self alphaviewtap:nil];
             
         }else{
             
//             self.isNearestForMe = NO;
             
             NeedOpenTwo2 = @"NeedOpenTwo2";
             
             OneID2 =[NSString stringWithFormat:@"%@",[self.LeftArrayID2 objectAtIndex:indexPath.row]];
             
             [self areaSelectmerchant];
             
             [self DiquDataTotableview2];
             
             [self.MiddleTableview2 reloadData];
             
             middleOpened2=NO;
             
             [self MiddleOpenBtn2];
             
         }
         
     }];
    
    [self.LeftTableview2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.LeftTableview2.layer setBorderWidth:0];
    
}

//地区二赋值
-(void) DiquDataTotableview2
{
    
    [self.MiddleTableview2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.MiddleArray2.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.MiddleArray2 objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=(MiddleCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         
         if (indexPath.row ==0) {
             
             for (int i=0; i<self.LeftArrayID2.count; i++) {
                
                 if ([OneID2 isEqualToString:[self.LeftArrayID2 objectAtIndex:i]]) {
                     
                     TwoID2 = @"";
                     [self.m_diquBtn setTitle:[self.LeftArray2 objectAtIndex:i] forState:UIControlStateNormal];
                     
                     break;
                 }
                 
                 
                 
             }
             
         }else{
             
             [self.m_diquBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
             TwoID2 =[NSString stringWithFormat:@"%@",[self.MiddleArrayID2 objectAtIndex:indexPath.row]];
         }
         
         
         pageIndex=1;
         m_pageIndex = 1;
         
//         self.m_searchBar.text = @"";
         
         //请求产品列表
//         if ( self.isNearestForMe ) {
//             
//             [self merchantAndProductRequest];
//             
//         }else{
         
             [self requestProductList1];
             
//         }
         
         [self alphaviewtap:nil];
     }];
    
    [self.MiddleTableview2 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.MiddleTableview2 .layer setBorderWidth:0];
    
}

//排序赋值
-(void) PaixuDataTotableview
{
    
    [self.RightTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.RightArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.RightArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=(RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         [self.m_paixuBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
         
         pageIndex=1;
         
         m_pageIndex = 1;
         
         
         if (indexPath.row == 0) {
             
//             self.isNearestForMe = NO;
             
             self.m_string = @"";
             
             self.m_order = @"";
             self.m_sort = @"";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self requestProductList1];
             
         }else if (indexPath.row ==1)
         {
             
//             self.isNearestForMe = NO;
             self.m_string = @"";
             
             self.m_order = @"desc";//降序
             self.m_sort = @"buyNum";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self requestProductList1];
             
         }else if (indexPath.row ==2)
         {
             
//             self.isNearestForMe = NO;
             self.m_string = @"";
             
             self.m_order = @"desc";//降序
             self.m_sort = @"Price";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self requestProductList1];
             
         }else if (indexPath.row ==3)
         {
             
//             self.isNearestForMe = NO;
             self.m_string = @"";
             
             self.m_order = @"asc";
             self.m_sort = @"Price";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self requestProductList1];
             
         }else if (indexPath.row ==4)
         {
             
             self.m_string = @"1";
             
             //离我最近
             self.m_order = @"";
             self.m_sort = @"";
             
             NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
             NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
             NSString *cityId = [CommonUtil getValueByKey:kSelectCityId];
             
             self.m_latiString = [NSString stringWithFormat:@"%f",[latitudeString floatValue]];
             self.m_longtiString = [NSString stringWithFormat:@"%f",[lontiduteString floatValue]];
             
             selectCity = cityId;
             
             // 判断如果分类为全部并且地区为全城、离我最近的时候按商户分类显示
//             if ( OneID2.length == 0 && TwoID.length == 0 ) {
//                 self.isNearestForMe = YES;
//                 
//                 // 离我最近时请求分区的数据
//                 [self merchantAndProductRequest];
//                 
//             }else{
             
//                 self.isNearestForMe = NO;
             
                 // 离我最近时请求分区的数据
                 [self requestProductList1];
//             }
         }
         
         [self alphaviewtap:nil];
     }];
    
    [self.RightTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.RightTableview.layer setBorderWidth:0];
    
}

/*- (void)LeftOpenBtn {
    
    if (leftOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.m_alphaView.alpha = 0;
            
            CGRect frame=self.LeftTableview.frame;
            frame.size.height=0;
            [self.LeftTableview setFrame:frame];
            
        } completion:^(BOOL finished){
            
            leftOpened=NO;
        }];
    }else{
        self.LeftTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            self.m_alphaView.alpha = 0.3;
            
            CGRect frame = self.LeftTableview.frame;
            frame.size.height = 300;
            [self.LeftTableview setFrame:frame];
            
            //默认打开上次二级
            if ([NeedOpenTwo isEqualToString:@"NeedOpenTwo"]) {
                middleOpened = NO;
                [self MiddleOpenBtn];
            }
            
        } completion:^(BOOL finished){
            
            leftOpened=YES;
            
        }];
    }
}*/

- (void)MiddleOpenBtn {
    
    if (middleOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
           
            
            CGRect frame=self.MiddleTableview.frame;
            frame.size.height=0;
//            [self.MiddleTableview setFrame:frame];
            
            [self.MiddleTableview setFrame:CGRectMake(10, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];

            
            self.m_alphaView.alpha = 0;

            
        } completion:^(BOOL finished){
            
            middleOpened=NO;
        }];
    }else{
        
        self.MiddleTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            CGRect frame = self.MiddleTableview.frame;
            
            int fr = self.MiddleArray.count * 44;
            if (fr > 300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            [self.MiddleTableview setFrame:CGRectMake(10, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            self.m_alphaView.alpha = 0.3;

            
        } completion:^(BOOL finished){
            
            middleOpened=YES;
            
        }];
        
    }
    
}

- (void)LeftOpenBtn2 {
    
    if (leftOpened2) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.LeftTableview2.frame;
            
            frame.size.height=0;
//            [self.LeftTableview2 setFrame:frame];
            
            [self.LeftTableview2 setFrame:CGRectMake(10, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];

            
            self.m_alphaView.alpha = 0;

            
        } completion:^(BOOL finished){
            
            leftOpened2=NO;
        }];
    }else{
        
        self.LeftTableview2.hidden = NO;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            CGRect frame=self.LeftTableview2.frame;
            frame.size.height=300;
//            [self.LeftTableview2 setFrame:frame];
            
            
            [self.LeftTableview2 setFrame:CGRectMake(10, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            self.m_alphaView.alpha = 0.3;

            
            //默认打开上次二级
            if ([NeedOpenTwo2 isEqualToString:@"NeedOpenTwo2"]) {
                middleOpened2 = NO;
                [self MiddleOpenBtn2];
            }
            
        } completion:^(BOOL finished){
            
            leftOpened2=YES;
            
        }];
        
    }
    
}

- (void)MiddleOpenBtn2 {
    
    
    if (middleOpened2) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.MiddleTableview2.frame;
            
            frame.size.height=0;
//            [self.MiddleTableview2 setFrame:frame];
            
            [self.MiddleTableview2 setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];

            
            
        } completion:^(BOOL finished){
            
            middleOpened2=NO;
        }];
    }else{
        
        self.MiddleTableview2.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.MiddleTableview2.frame;
            
            
            int fr = self.MiddleArray2.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
//            [self.MiddleTableview2 setFrame:frame];
            
            
            [self.MiddleTableview2 setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
        } completion:^(BOOL finished){
            
            middleOpened2=YES;
            
            
        }];
    }
    
}

- (void)RightOpenBtn {
    
    
    if (rightOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.RightTableview.frame;
            
            frame.size.height=0;
//            [self.RightTableview setFrame:frame];
            
            [self.RightTableview setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            self.m_alphaView.alpha = 0;
            
            
        } completion:^(BOOL finished){
            
            rightOpened=NO;
        }];
    }else{
        
        self.RightTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.RightTableview.frame;
            
            int fr = self.RightArray.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
           
            [self.RightTableview setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];

            
            self.m_alphaView.alpha = 0.3;
            
        } completion:^(BOOL finished){
            
            rightOpened=YES;
            
        }];
        
    }
    
}

- (IBAction)alphaviewtap:(id)sender
{
    leftOpened = YES;
    middleOpened = YES;
    leftOpened2 = YES;
    middleOpened2 = YES;
    rightOpened = YES;
//    [self LeftOpenBtn];
    [self MiddleOpenBtn];
    [self LeftOpenBtn2];
    [self MiddleOpenBtn2];
    [self RightOpenBtn];
}

#pragma mark - UINetWork request
- (void)requestProductList1{
  
    // self.dp_isfenqu = @"";  ///
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    NSString *maxPrice = @"";
    
    NSString *minPrice = @"";
    
    maxPrice = @"";
    
    minPrice = @"";
    
    if (TwoID==nil||[TwoID isEqualToString:@""]) {
        TwoID =@"";
    }
    if (OneID2==nil||[OneID2 isEqualToString:@""]) {
        OneID2 =@"";
    }
    if (TwoID2==nil||[TwoID2 isEqualToString:@""]) {
        TwoID2 =@"";
    }
  
    // 设置的tableView
    PullTableView *tableView = (PullTableView *)[contentItems objectAtIndex:m_index];
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%d", m_pageIndex], @"pageIndex",
                                  selectCity, @"cityId",
                                  OneID2, @"areaId",
                                  TwoID2, @"districtId",
                                  //                                  OneID, @"categoryId",
                                  TwoID,@"classId",
                                  [NSString stringWithFormat:@"%@",self.m_order],@"order",
                                  [NSString stringWithFormat:@"%@",self.m_sort],@"sort",
                                  [NSString stringWithFormat:@"%@",self.m_longtiString],@"mapX",
                                  [NSString stringWithFormat:@"%@",self.m_latiString],@"mapY",
                                  maxPrice,@"maxPrice",
                                  minPrice,@"smlPrice",
                                  @"",@"svcName",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];//  CommodityList_1_0.ashx
    [httpClient request:@"CommodityList_1_0.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"serviceList"];
            
            NSMutableArray *productList = [[NSMutableArray alloc]initWithCapacity:0];
            
            DP_pageIndex = 1;
            
            // 如果字典有值，下啦刷新的时候删除第几个数组重新赋值
            if ( self.m_dic.count != 0 ) {
                
                [self.m_dic removeObjectForKey:[NSString stringWithFormat:@"%i",m_index]];
                
            }
            
            if (m_pageIndex == 1) {

                if (metchantShop == nil || metchantShop.count == 0) {
                    
                    tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    self.m_emptyLabel.text = @"";
                    
                    // 数组中插入第一条数据
                    if ( metchantShop == nil ) {
                        
                        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
                        
                        [productList insertObject:arr atIndex:0];

                    }else{
                        
                        [productList insertObject:metchantShop atIndex:0];

                    }
                    
                    if ( productList != nil ) {
                        
                         [self.m_dic setObject:productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                    }
                    
                    [self ServicesFromDP];
                    
                } else {
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    tableView.hidden = NO;
                    
                    //如果第一页数据小于6个，调大众点评数据接在后面
                    if (metchantShop.count <= 6) {
                        
                        // 将请求下来的数组先添加到字典里面
                        [productList insertObject:metchantShop atIndex:0];
                        
                        if ( productList != nil ) {
                            
                             [self.m_dic setObject:productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                        }

                        [self ServicesFromDP];
                        
                    }
                    else{
                       
                        // 判断数组是否有值，如果有值的话则直接替换，没值的话则直接插入一条数据
                        if ( productList.count != 0 ) {
                            
                            NSMutableArray *arr = [productList objectAtIndex:0];
                            [arr addObjectsFromArray:metchantShop];
                            [productList replaceObjectAtIndex:0 withObject:arr];
                      
                        }else{
                            
                            // 将请求下来的数组先添加到字典里面
                            [productList insertObject:metchantShop atIndex:0];
                        }
                        
                        // 插入一个空的数组
                        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
                        
                        [productList insertObject:arr atIndex:1];
                        
                        // 将请求下来的数组先添加到字典里面
                        
                        if ( productList != nil ) {
                            
                              [self.m_dic setObject:productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                        }
                        
                      
                        
                        [tableView reloadData];
                        

                        
                    }
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    m_pageIndex--;
                    
                    [self ServicesFromDP];
                    
                } else {
                    //如果最后一页数据小于6个，调大众点评数据接在后面
                    if (metchantShop.count<=6) {
                      
                        // 将请求下来的数组先添加到字典里面
                        [self.m_productList addObject:metchantShop];
                        
                        // 数组中插入第一条数据
                        [productList insertObject:metchantShop atIndex:0];
                        
                        if ( productList != nil ) {
                            
                             [self.m_dic setObject:productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                        }
                      
                        [self ServicesFromDP];
                        
                        
                    }
                    else{
                        
                        // 判断数组是否有值，如果有值的话则直接替换，没值的话则直接插入一条数据
                        if ( productList.count != 0 ) {
                            
                            NSMutableArray *arr = [productList objectAtIndex:0];
                            [arr addObjectsFromArray:metchantShop];
                            [productList replaceObjectAtIndex:0 withObject:arr];
                            
                        }else{
                            
                            // 将请求下来的数组先添加到字典里面
                            [productList insertObject:metchantShop atIndex:0];
                        }
                        
                        // 插入一个空的数组
                        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
                        
                        [productList insertObject:arr atIndex:1];
                        
                        if ( productList != nil ) {
                            
                              [self.m_dic setObject:productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                        }
                        
                        
                        [tableView reloadData];
                    
                    }
                }
            }
            
            
            tableView.hidden = NO;
            
//            [tableView reloadData];
            
        } else {
            if (m_pageIndex > 1) {
                m_pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        tableView.pullLastRefreshDate = [NSDate date];
        tableView.pullTableIsRefreshing = NO;
        tableView.pullTableIsLoadingMore = NO;
        
        
        
    } failure:^(NSError *error) {
        if (m_pageIndex > 1) {
            m_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        tableView.pullTableIsRefreshing = NO;
        tableView.pullTableIsLoadingMore = NO;
    }];
    
    
}

- (void)ServicesFromDP{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *url = @"v1/deal/find_deals";
    
    NSString *city =[CommonUtil getValueByKey:kSelectCityName];//城市
    
    NSString *category;
        
    if ([self.m_allCategoryBtn.titleLabel.text isEqualToString:@"电影院"])
        {
            category = @"院线影院";
        }
    else
        {
            category = self.m_allCategoryBtn.titleLabel.text;//类别
        }

    
    float latitude = [[CommonUtil getValueByKey:kLatitudeKey] floatValue];
    float longitude = [[CommonUtil getValueByKey:kLongitudeKey] floatValue];
    
    if (latitude == 0.000000&&longitude == 0.000000) {
        
        latitude = 31.3;
        longitude = 120.6;
    }
    
    int sort = 0;
    
    if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"默认排序"])//排序)
    {
        sort = 1;
        
        
    }else if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"销量最多"])
    {
        sort = 4;
        
        
    }else if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"价格最高"])
    {
        sort = 3;
        
        
    }else if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"价格最低"])
    {
        sort = 2;
        
        
    }else if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"离我最近"])
    {
        sort = 7;
        
    }
    
    NSString * params;
    
    if ([self.m_diquBtn.titleLabel.text isEqualToString:@"全城"]) {
        
        if ([self.m_allCategoryBtn.titleLabel.text isEqualToString:@"全部分类"]) {
            
            params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&sort=%d&page=%d&limit=20",city,latitude,longitude,sort,DP_pageIndex];
            
        }else{
        
         params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&category=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,category,sort,DP_pageIndex];
        }

    }else{
        if ([self.m_allCategoryBtn.titleLabel.text isEqualToString:@"全部分类"]) {
            
        params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&region=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,self.m_diquBtn.titleLabel.text,sort,DP_pageIndex];
            
        }else{
        
        params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&category=%@&region=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,category,self.m_diquBtn.titleLabel.text,sort,DP_pageIndex];
        }
        
    }
    
    
    //结果排序，1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先
    
    [[[AppDelegate instance] dpapi] requestWithURL:url paramsString:params delegate:self];
    
    
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    
    [SVProgressHUD dismiss];
    
    if (DP_pageIndex > 1) {
        DP_pageIndex--;
    }
    
    
    // 设置的tableView
    PullTableView *tableView = (PullTableView *)[contentItems objectAtIndex:m_index];
    
    if (self.m_productList.count == 0) {
        
        tableView.hidden = YES;
        
        self.m_emptyLabel.hidden = NO;
        
        self.m_emptyLabel.text = @"暂无商品数据！";
        
    }
    
    //    [SVProgressHUD showErrorWithStatus:@"请求失败"];
    
    tableView.pullTableIsRefreshing = NO;
    tableView.pullTableIsLoadingMore = NO;
    
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    // 设置的tableView
    PullTableView *tableView = (PullTableView *)[contentItems objectAtIndex:m_index];

    NSString * success = [result valueForKey:@"status"];
    
    if ([success isEqualToString:@"OK"]) {
        
        [SVProgressHUD dismiss];
        
        NSMutableArray *l_productList = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",m_index]];
        

        NSMutableArray *metchantShop = [result valueForKey:@"deals"];
        
        if (DP_pageIndex == 1) {
            
            if (metchantShop == nil || metchantShop.count == 0) {
                
                //暂无大众点评数据
                
//                if (l_productList.count==0) {
//
//                    if ( arr.count == 0 ) {
                
                tableView.hidden = YES;
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_emptyLabel.text = @"暂无商品数据！";
                
                tableView.pullLastRefreshDate = [NSDate date];
                tableView.pullTableIsRefreshing = NO;
                tableView.pullTableIsLoadingMore = NO;
                
                // 如果数组有值的话则直接替换，没有值的话则直接插入
                if ( l_productList.count == 2 ) {
                    
                    
                    if ( metchantShop == nil ) {
                        
                        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
                        
                        [l_productList replaceObjectAtIndex:1 withObject:arr];
                        
                    }else{
                        
                        [l_productList replaceObjectAtIndex:1 withObject:metchantShop];
                        
                    }
                    
                    
                    if ( l_productList != nil ) {
                        
                         [self.m_dic setObject:l_productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                    }
                    

                }else{
                    
                    if ( metchantShop == nil ) {
                        
                        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
                        
                        [l_productList insertObject:arr atIndex:1];
                        
                    }else{
                        
                        [l_productList insertObject:metchantShop atIndex:1];

                    }
                    
                    if ( l_productList != nil ) {
                        
                        [self.m_dic setObject:l_productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                    }
                    

                }
                
                
                return;

//                    }
//                }
            
                
            } else {
                
                
                self.DPdealsarray = metchantShop;
                
                [l_productList insertObject:metchantShop atIndex:1];
                
                if ( l_productList != nil ) {
                    
                     [self.m_dic setObject:l_productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                }
                                
                self.m_emptyLabel.hidden = YES;
                
                tableView.hidden = NO;
                
            }
        } else {
            if (metchantShop == nil || metchantShop.count == 0) {
                
                DP_pageIndex--;
                
            } else {
                
                
                [self.DPdealsarray addObjectsFromArray:metchantShop];
                
                if ( l_productList.count == 2 ) {
                    
                    NSMutableArray *arr = [l_productList objectAtIndex:1];
                    
                    [arr addObjectsFromArray:metchantShop];
                    
                    [l_productList replaceObjectAtIndex:1 withObject:arr];

                }else{
                    
                    [l_productList insertObject:metchantShop atIndex:1];
                    
                }
                
                if ( l_productList != nil ) {
                    
                    [self.m_dic setObject:l_productList forKey:[NSString stringWithFormat:@"%i",m_index]];
                }
               
               
            }
        }
        
        
        tableView.hidden = NO;
        
        [tableView reloadData];
        
    } else {
        if (DP_pageIndex > 1) {
            DP_pageIndex--;
        }
        //        NSString *msg = [request valueForKey:@"msg"];
        //        [SVProgressHUD showErrorWithStatus:msg];
    }
    tableView.pullLastRefreshDate = [NSDate date];
    tableView.pullTableIsRefreshing = NO;
    tableView.pullTableIsLoadingMore = NO;

}


#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    pageIndex = 1;
    m_pageIndex = 1;
    
    [self performSelector:@selector(requestProductList1) withObject:nil];

}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    NSMutableArray *l_arr = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",m_index]];
    
    NSMutableArray *arr = [l_arr objectAtIndex:1];
    
    if ( arr.count !=  0 ) {
        
        DP_pageIndex++;
        [self performSelector:@selector(ServicesFromDP) withObject:nil];
        
    }else{
        
        m_pageIndex++;
        [self performSelector:@selector(requestProductList1) withObject:nil];
    }
    
}

@end
