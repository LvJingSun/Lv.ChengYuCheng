//
//  OfficeLJViewController.m
//  HuiHui
//
//  Created by mac on 2016/12/23.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "OfficeLJViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface OfficeLJViewController ()

@end

@implementation OfficeLJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titletext;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize contentSize = [self sizeWithText:self.contenttext font:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(SCREEN_WIDTH * 0.9, 0)];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 0, SCREEN_WIDTH * 0.9, contentSize.height)];
    
    lab.numberOfLines = 0;
    
    lab.font = [UIFont systemFontOfSize:18];
    
    lab.text = self.contenttext;
    
    [self.view addSubview:lab];
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
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
