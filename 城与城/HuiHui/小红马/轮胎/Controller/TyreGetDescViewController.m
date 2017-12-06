//
//  TyreGetDescViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TyreGetDescViewController.h"
#import "RedHorseHeader.h"

@interface TyreGetDescViewController ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UITextView *textView;

@end

@implementation TyreGetDescViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"帮助";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(popTyreVC)];
    
    UILabel *titlelab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, 10, ScreenWidth * 0.9, 30)];
    
    titlelab.textColor = RH_NAVTextColor;
    
    titlelab.textAlignment = NSTextAlignmentCenter;
    
    titlelab.font = [UIFont systemFontOfSize:18];
    
    self.titleLab = titlelab;
    
    [self.view addSubview:titlelab];
    
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, CGRectGetMaxY(titlelab.frame) + 10, ScreenWidth * 0.9, ScreenHeight - 124)];
    
    self.textView = textview;
    
    textview.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:textview];
    
    [self requestForHelp];
    
}

- (void)popTyreVC {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)requestForHelp {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.DescType,@"Type", nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"GetTireExplain.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            self.titleLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"TireTitle"]];
            
            NSString *str = [NSString stringWithFormat:@"%@",[json valueForKey:@"TireDesc"]];
            
            self.textView.text = [str stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
