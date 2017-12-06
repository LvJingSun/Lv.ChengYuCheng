//
//  ShareGameToHuiHuiViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ShareGameToHuiHuiViewController.h"
#import "LJConst.h"
#import "UIImageView+AFNetworking.h"

@interface ShareGameToHuiHuiViewController () {

    NSMutableDictionary *imageDic;
    
}

@property (nonatomic, weak) UIView *bgview;

@property (nonatomic, weak) UIImageView *imageview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *descLab;

@property (nonatomic, weak) UITextField *field;

@property (nonatomic, weak) UIButton *shareBtn;

@end

@implementation ShareGameToHuiHuiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    imageDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    self.title = @"圈子分享";
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self initWithShareView];

}

- (void)initWithShareView {

    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, 10, _WindowViewWidth * 0.9, 90)];
    
    self.bgview = bg;
    
    bg.backgroundColor = [UIColor whiteColor];
    
    bg.layer.masksToBounds = YES;
    
    bg.layer.cornerRadius = 5;
    
    bg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    bg.layer.borderWidth = 1.f;
    
    [self.view addSubview:bg];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 80)];
    
    self.imageview = img;
    
    [img setImageWithURL:[NSURL URLWithString:self.shareImg] placeholderImage:[UIImage imageNamed:@""]];
    
    NSLog(@"shareImg  %@",self.shareImg);
    
    [bg addSubview:img];
    
    CGFloat titleX = CGRectGetMaxX(img.frame) + 5;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 15, _WindowViewWidth * 0.9 - 5 - titleX, 20)];
    
    self.titleLab = title;
    
    title.text = self.shareTitle;
    
    title.textColor = [UIColor darkGrayColor];
    
    title.font = [UIFont systemFontOfSize:17];
    
    [bg addSubview:title];
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(titleX, CGRectGetMaxY(title.frame) + 5, _WindowViewWidth * 0.9 - 5 - titleX, 85 - CGRectGetMaxY(title.frame) - 5)];
    
    self.descLab = desc;
    
    desc.text = self.shareDesc;
    
    desc.textColor = [UIColor lightGrayColor];
    
    desc.font = [UIFont systemFontOfSize:15];
    
    desc.numberOfLines = 0;
    
    [bg addSubview:desc];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, CGRectGetMaxY(bg.frame) + 10, _WindowViewWidth * 0.9, 40)];
    
    self.field = field;
    
    field.layer.borderWidth = 0.5f;
    
    field.layer.borderColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.].CGColor;
    
    field.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:field];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_WindowViewWidth * 0.05, CGRectGetMaxY(field.frame) + 20, _WindowViewWidth * 0.9, 40)];
    
    self.shareBtn = btn;
    
    btn.layer.masksToBounds = YES;
    
    btn.layer.cornerRadius = 5;
    
    [btn setBackgroundColor:FSB_StyleCOLOR];
    
    [btn setTitle:@"分享" forState:0];
    
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    
    [btn addTarget:self action:@selector(pushShare) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if ([self.field isFirstResponder]) {
        
        [self.field resignFirstResponder];
        
    }
    
}

- (void)pushShare {
    
    [imageDic setValue:[self getImageData:self.imageview] forKey:[NSString stringWithFormat:@"picUrl0"]];

    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSString * key = [CommonUtil getServerKey];
    
    UIDevice *dev = [UIDevice currentDevice];
    
    NSString *devname =  [NSString stringWithFormat:@"%@",dev.model];
    
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           devname,@"source",
                           [NSString stringWithFormat:@"%@",self.field.text],@"contents",
                           @"1",@"picCount",
                           @"0",@"serviceID",
                           @"0",@"activityID",
                           @"WebViewShare",@"dynamicType",
                           self.shareTitle,@"title",
                           self.shareDesc,@"subTitle",
                           self.shareUrl,@"webUrl",
                           @"0",@"merchantShopID",
                           @"0",@"dealId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    [httpClient multiRequestSpace:@"DynamicShareAdd.ashx" parameters:param files:imageDic success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            //保存本地更新时间
            NSString *time = [NSString stringWithFormat:@"%f", (double)[[NSDate date] timeIntervalSince1970]];
            [CommonUtil addValue:[NSString stringWithFormat:@"%.16f",[time doubleValue]-500] andKey:Spaceuploadtime];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(leftClicked) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
}

- (void)leftClicked {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
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
