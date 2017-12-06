//
//  AddFriend_ScrollImageCell.m
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "AddFriend_ScrollImageCell.h"
#import "Add_FriendsCell.h"

#import "Add_MoreFriends.h"
#import "Add_ScrollFrame.h"
#import "Add_FriendsCell.h"

#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation AddFriend_ScrollImageCell

- (void)requestCollectData {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           nil];
    
    [httpClient request:@"recommendFriends.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"listCommFr"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                Add_MoreFriends *i_friend = [[Add_MoreFriends alloc] initWithDict:dd];
                
                Add_ScrollFrame *frame = [[Add_ScrollFrame alloc] init];
                
                frame.friendModel = i_friend;
                
                [mut addObject:frame];
                
            }
            
            self.collectArray = mut;
            
            [self.collectionView reloadData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

+ (instancetype)AddFriend_ScrollImageCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"AddFriend_ScrollImageCell";
    
    AddFriend_ScrollImageCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[AddFriend_ScrollImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = 5;
        //最小两行之间的间距
        layout.minimumLineSpacing = 5;
        //这个是横向滑动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 155) collectionViewLayout:layout];

        self.collectionView = collectionview;
        
        collectionview.backgroundColor = [UIColor whiteColor];
        
        collectionview.delegate = self;
        
        collectionview.dataSource = self;
        
        [collectionview registerClass:[Add_FriendsCell class] forCellWithReuseIdentifier:@"Add_FriendsCell"];
        
        [self addSubview:collectionview];
        
        self.height = CGRectGetMaxY(collectionview.frame);
        
        [self requestCollectData];
        
    }
    
    return self;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.collectArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Add_FriendsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Add_FriendsCell" forIndexPath:indexPath];
    
    Add_ScrollFrame *frame = self.collectArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Add_ScrollFrame *frame = self.collectArray[indexPath.row];
    
    return frame.scr_size;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
