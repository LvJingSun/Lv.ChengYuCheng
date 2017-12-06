//
//  CategoryViewController.m
//  HuiHui
//
//  Created by mac on 14-7-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CategoryViewController.h"

#import "Ca_productListViewController.h"


@interface CategoryViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@end

@implementation CategoryViewController

@synthesize m_categoryList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        dbhelp = [[DBHelper alloc]init];
        
        m_categoryList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"分类"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_categoryList = [dbhelp queryCategory];
    
    
    // 初始化scrollerView
    [self initScrollerView];

    
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

- (void)initScrollerView{
    
    CGFloat width = WindowSizeWidth;
    CGFloat padding = 10;
    // 记录总坐标
    CGFloat  sum = 0.0;
    
    CategoryView *preView = [[CategoryView alloc]init];
    
    for (int i = 0; i < [self.m_categoryList count]; i ++) {
        
        CategoryView *currentView = [[CategoryView alloc]init];
        
        currentView.delegate = self;
        
        NSDictionary *dic = [self.m_categoryList objectAtIndex:i];
        
        NSMutableArray *arr = [dbhelp queryProject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]]];
        
        preView = currentView;
        
        [currentView setArray:arr withDic:dic];
        
        currentView.frame = CGRectMake(0, sum, width, currentView.m_view.frame.size.height + 20);
        
        sum = sum + preView.frame.size.height + padding;
        
        [self.m_scrollerView addSubview:currentView];
        
        self.m_scrollerView.contentSize = CGSizeMake(WindowSizeWidth, sum);
        
    }
    
}

#pragma mark - CategoryDelegate
- (void)getCategoryClassId:(NSDictionary *)dic{
    
    NSString *classId = @"";
    // 判断分类的Id,如果classKey是-1表示选中的是全部，否则是其他的分类
    if ( [[dic objectForKey:@"classKey"] isEqualToString:@"-1"] ) {
        
        classId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"codeKey"]];
    
    }else{
        
        classId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"classKey"]];

    }

    // 进入商品列表
    Ca_productListViewController *VC = [[Ca_productListViewController alloc]initWithNibName:@"Ca_productListViewController" bundle:nil];
    VC.TwoID = classId;
    VC.m_titleString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"titleKey"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
