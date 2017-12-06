//
//  KeyInfoCell.m
//  baozhifu
//
//  Created by mac on 13-6-19.
//  Copyright (c) 2013年 mac. All rights reserved.
//
#import "KeyInfoCell.h"
#import "CommonUtil.h"

@interface KeyInfoCell()

@end

@implementation KeyInfoCell

@synthesize m_dic;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)btnUse:(id)sender {
    if (status > 0) {
        return;
    }
    [self.rootViewController useKey:self.txt_title.text];
}

- (IBAction)btnSelect:(id)sender {
    
    if (status > 0) {
        return;
    }
    
    UIButton *btn = (UIButton *)sender;
    
    UIButton *button = self.btnSelect;
    keySelected = !keySelected;
    
    if (keySelected) {
        
        [self.m_dic setValue:@"1" forKey:[NSString stringWithFormat:@"%i",btn.tag]];
        
        [button setBackgroundImage:[UIImage imageNamed:@"mykey_btn_selected"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    } else {
        
        [self.m_dic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",btn.tag]];
        
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    [self.rootViewController selectKey:self.txt_title.text andAdd:keySelected withDic:self.m_dic];
}

- (void)setValue:(NSDictionary *)key withItems:(NSDictionary *)items{
    
    status = [[key objectForKey:@"keyStatus"] intValue];
    
    if (status > 0) {
        self.btnSelect.hidden = YES;
        self.btnUse.hidden = YES;
        self.btnRefund.hidden = YES;
    }else{
        
        self.btnSelect.hidden = NO;
        self.btnUse.hidden = NO;
        
        NSString *keyType = [items objectForKey:@"keyType"];
        // 标志是否有退款功能的参数 1具有退款功能 0不具有退款功能
        NSString *isReturn = [items objectForKey:@"isreturn"];
        
        if ([KEY_TYPE_SERVICE isEqualToString:keyType]) {
            
            if ( [isReturn isEqualToString:@"1"] ) {
                // 商品KEY
                if ( [[items objectForKey:@"SVCIsAnyTimeReturn"] isEqualToString:@"Yes"] ) {
                    
                    self.btnRefund.hidden = NO;
                    
                }else{
                    
                    self.btnRefund.hidden = YES;
                }
                
            }else{
                
                self.btnRefund.hidden = YES;
                
            }
            
            
        } else if ([KEY_TYPE_ACTIVITY isEqualToString:keyType]){
            
            if ( [isReturn isEqualToString:@"1"] ) {

                // 活动KEY
                if ( [[items objectForKey:@"ACTIsAnyTimeReturn"] isEqualToString:@"Yes"] ) {
                    
                    self.btnRefund.hidden = NO;
                    
                }else{
                    
                    self.btnRefund.hidden = YES;
                    
                }

            }else{
                
                self.btnRefund.hidden = YES;

            }
            
        }else{
            
            if ( [isReturn isEqualToString:@"1"] ) {
                
                // 抢购KEY
                if ( [[items objectForKey:@"QGIsAnyTimeReturn"] isEqualToString:@"Yes"] ) {
                    
                    self.btnRefund.hidden = NO;
                    
                }else{
                    
                    self.btnRefund.hidden = YES;
                    
                }
            }else{
                
                self.btnRefund.hidden = YES;

            }
            
            
        }
        
        
        //        self.btnRefund.hidden = NO;
    }
    self.txt_title.text = [key objectForKey:@"keyVal"];
    
    //    @"未使用", @"0",
    //    @"已使用", @"1",
    //    @"已退款", @"2",
    //    @"已过期", @"3",
    if ( [[key objectForKey:@"keyStatus"] isEqualToString:@"0"] ) {
        
        NSString *statusValue = [NSString stringWithFormat:@"%@-有效期至%@", [[CommonUtil keyStatusDict] objectForKey:[key objectForKey:@"keyStatus"]], [key objectForKey:@"expirationDate"]];
        
        self.txt_status.text = statusValue;
        
    }else if ( [[key objectForKey:@"keyStatus"] isEqualToString:@"1"] ){
        
        NSString *statusValue = [NSString stringWithFormat:@"%@-使用日期:%@", [[CommonUtil keyStatusDict] objectForKey:[key objectForKey:@"keyStatus"]], [key objectForKey:@"useDate"]];
        
        self.txt_status.text = statusValue;
        
    }else if ( [[key objectForKey:@"keyStatus"] isEqualToString:@"2"] ){
        
        NSString *statusValue = [NSString stringWithFormat:@"%@", [[CommonUtil keyStatusDict] objectForKey:[key objectForKey:@"keyStatus"]]];
        
        self.txt_status.text = statusValue;
        
    }else if ( [[key objectForKey:@"keyStatus"] isEqualToString:@"3"] ){
        
        NSString *statusValue = [NSString stringWithFormat:@"%@-有效期至%@", [[CommonUtil keyStatusDict] objectForKey:[key objectForKey:@"keyStatus"]], [key objectForKey:@"expirationDate"]];
        
        self.txt_status.text = statusValue;
        
    }else{
        
        
    }
    
    
    
    
    
}


@end
