//
//  HH_customRuleViewController.m
//  HuiHui
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_customRuleViewController.h"

#import "AppDelegate.h"

@interface HH_customRuleViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UILabel *m_menuName;

@property (weak, nonatomic) IBOutlet UIButton *m_jiaBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_jianBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_numCount;

- (IBAction)addMenuClicked:(id)sender;

- (IBAction)minuMenuClicked:(id)sender;

@end

@implementation HH_customRuleViewController

@synthesize m_customList;

@synthesize m_menuString;

@synthesize m_index;

@synthesize delegate;

@synthesize m_countDic;

@synthesize m_sectionIndex;

@synthesize m_amount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_customList = [[NSMutableArray alloc]initWithCapacity:0];

//        m_countList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_countDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_index = 0;
        
        m_sectionIndex = 0;
        
        m_amount = 0;

    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"自定义参数"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"确定" action:@selector(sureCustomrules)];
    
    // 赋值
    self.m_menuName.text = [NSString stringWithFormat:@"%@",self.m_menuString];
    
    [self.m_jiaBtn.layer setBorderWidth:1.0]; //边框宽度
    [self.m_jianBtn.layer setBorderWidth:1.0]; //边框宽度
    [self.m_numCount.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){190/255.0, 204/255.0, 205/255.0, 1 });
    [self.m_jiaBtn.layer setBorderColor:colorref];//边框颜色
    [self.m_jianBtn.layer setBorderColor:colorref];//边框颜色
    [self.m_numCount.layer setBorderColor:colorref];//边框颜色
    
    [self.m_numCount setTitle:@"1" forState:UIControlStateNormal];
    
    NSLog(@"amonut = %i",self.m_amount);
    
    // 添加字典里的值
    if ( self.m_amount == 0 ) {
        
        // 存放字典中的值
        NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",self.m_sectionIndex]];
        
        int countValue = [count intValue];
        
        countValue = countValue + 1;
        
        [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",self.m_sectionIndex]];
        
    }
    
    
    // 初始化scrollerView
    [self initScrollerView];
    
    
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

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)sureCustomrules{
    
    NSLog(@"%@",Appdelegate.m_customNameDic);
    
    for (int i = 0; i < self.m_customList.count; i++) {
        
        NSDictionary *dic = [self.m_customList objectAtIndex:i];
        
        NSString *string = [NSString stringWithFormat:@"%@",[Appdelegate.m_customNameDic objectForKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeName"]]]];
        
        
        if ( string.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请选择自定义的参数"];
            
            return;
            
        }

    }
    
    // 如果数量为0 的时候则直接返回上一级
    NSString *countString = [NSString stringWithFormat:@"%@",self.m_numCount.titleLabel.text];
    
    if ( [countString isEqualToString:@"0"] ) {
        
         [self goBack];
        
    }else{
        
        
        NSString *indexString = [NSString stringWithFormat:@"%i",self.m_index];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:countString,@"amount",indexString,@"index", nil];
        
        // 返回上一级执行代理方法
        if ( self.delegate && [self.delegate respondsToSelector:@selector(addMenugetIndex:withCountDic:)] ) {
            
            
            [self.delegate performSelector:@selector(addMenugetIndex:withCountDic:) withObject:dic withObject:self.m_countDic];
            
        }
        
        [self goBack];
        
    }
    
    
   
    
}

- (void)initScrollerView{
    
    CGFloat width = WindowSizeWidth;
    CGFloat padding = 10;
    // 记录总坐标
    CGFloat  sum = 0.0;
    
    CustomRuleView *preView = [[CustomRuleView alloc]init];
    
    for (int i = 0; i < [self.m_customList count]; i ++) {
        
        CustomRuleView *currentView = [[CustomRuleView alloc]init];
        
//        currentView.delegate = self;
        
        NSDictionary *dic = [self.m_customList objectAtIndex:i];
        
        // 设置对应的名称所对应的值
        [Appdelegate.m_customRulesDic setObject:@"" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeName"]]];

        [Appdelegate.m_customNameDic setObject:@"" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeName"]]];
        
        
        NSMutableArray *arr = [dic objectForKey:@"ValueList"];
        
        preView = currentView;
        
        [currentView setArray:arr withDic:dic withIndex:i];
        
        currentView.frame = CGRectMake(0, sum, width, currentView.m_view.frame.size.height + 20);
        
        sum = sum + preView.frame.size.height + padding;
        
        [self.m_scrollerView addSubview:currentView];
        
        self.m_scrollerView.contentSize = CGSizeMake(WindowSizeWidth, sum);
        
    }
    
}

#pragma mark - BtnClicked
- (IBAction)addMenuClicked:(id)sender {
    
    self.m_jianBtn.hidden = NO;
    self.m_numCount.hidden = NO;
    
    NSString *countString = [NSString stringWithFormat:@"%@",self.m_numCount.titleLabel.text];
    
    NSLog(@"countString = %@",countString);
    
    int count = [countString intValue];
    
    NSLog(@"count = %i",count);
    
    // 替换数组里面的值
//    [self.m_countList replaceObjectAtIndex:btn.tag withObject:[NSString stringWithFormat:@"%i",count]];
    
//    NSString *count11111 = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",self.m_sectionIndex]];
    
//    self.m_amount = 1;

    count ++;
    
    // 赋值
    [self.m_numCount setTitle:[NSString stringWithFormat:@"%i",count] forState:UIControlStateNormal];
    
    // 刷新数据
//    [self refreshData];
    
    
//    NSString *indexString = [NSString stringWithFormat:@"%i",self.m_index];
    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:countString,@"amount",indexString,@"index", nil];
   
}

- (IBAction)minuMenuClicked:(id)sender {
    
    NSString *countString = [NSString stringWithFormat:@"%@",self.m_numCount.titleLabel.text];
    
    int count = [countString intValue];
    
    count --;
    
    NSLog(@"count = %i",count);
    
    
    if ( count == 0 ) {
        
//        self.m_amount = 0;
        
        if ( self.m_amount == 0 ) {
            
            // 添加字典里的值
            // 计算左边tableView上面数量的显示======
            NSString *count11 = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",self.m_sectionIndex]];
            
            int countValue = [count11 intValue];
            
            if ( countValue != 0 ) {
                
                countValue = countValue - 1;
                
            }else{
                
                countValue = 0;
            }
            
            
            NSLog(@"countValue = %i",countValue);
            
            
            // 赋值到字典里
            [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",self.m_sectionIndex]];
            
            
        }
        
       
        

        // 赋值
        [self.m_numCount setTitle:[NSString stringWithFormat:@"%i",count] forState:UIControlStateNormal];
        
        self.m_jianBtn.hidden = YES;
        self.m_numCount.hidden = YES;
        
        
        
    }else{
        
        self.m_jianBtn.hidden = NO;
        self.m_numCount.hidden = NO;
        
        // 赋值
        [self.m_numCount setTitle:[NSString stringWithFormat:@"%i",count] forState:UIControlStateNormal];
        
    }

}

- (void)refreshData{
    
    
    
    
}

@end
