//
//  Other_keyDetailViewController.m
//  HuiHui
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "Other_keyDetailViewController.h"

#import "QRCodeGenerator.h"

@interface Other_keyDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_keyLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_merchantLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_statusLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_codeImagV;


@end

@implementation Other_keyDetailViewController

@synthesize item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        item = [[NSDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"其他KEY值详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 赋值
    self.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"typeValue"]];
    self.m_keyLabel.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"eleCouponsValue"]];
    self.m_merchantLabel.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"allName"]];
    self.m_timeLabel.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"keyValDate"]];
    
    NSString *status = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"keystatus"]];
    
    // KEY值状态（已退款2、已使用1、未使用0）
    if ( [status isEqualToString:@"0"] ) {
        
        self.m_statusLabel.text = @"未使用";
        
        self.m_statusLabel.textColor = [UIColor greenColor];
        
    }else if ( [status isEqualToString:@"1"] ) {
        
        self.m_statusLabel.text = @"已使用";
        
        self.m_statusLabel.textColor = [UIColor redColor];

    }else if ( [status isEqualToString:@"2"] ){
        
        self.m_statusLabel.text = @"已退款";
        
        self.m_statusLabel.textColor = [UIColor redColor];

    }else{
        

    }
    
    // 生成二维码图片
    UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.item objectForKey:@"eleCouponsValue"] imageSize:self.m_codeImagV.frame.size.width];
    [self.m_codeImagV setImage:codeImage];
    
    
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

@end
