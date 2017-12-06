//
//  ContactsDelegateViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ContactsDelegateViewController.h"
#import "LJConst.h"

@interface ContactsDelegateViewController ()

@end

@implementation ContactsDelegateViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"隐私协议"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    textview.textColor = [UIColor darkTextColor];
    
    textview.text = @"隐私政策\n\n我们不会收集及以任何形式储存来自你社交网路的任何资讯或销售给广告或其它营运机构。\n\n个人信息\n\n当你透过社交网路进行分享时，可能会要求输入帐号密码，但该资讯由iOS系统管理，App不会以任何形式储存帐号密码，也不会收集及以任何形式储存您在社交网路上的任何个人资讯。\n\n隐私政策条款\n\n使用本App即表示您同意此隐私政策的条款和条件。如果您不同意本政策，请不要使用该App。我们保留权利，在我们决定更改，修改，增加或删除本政策的部分，在任何时候。请定期浏览此页面查阅任何修改。如果您继续使用我们的App以后的任何更改这些条款的发布将意味着你已经接受了这些调整。";
    
    textview.font = [UIFont systemFontOfSize:17];
    
    [self.view addSubview:textview];
    
}

- (void)leftClicked{
    
    [self goBack];
    
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
