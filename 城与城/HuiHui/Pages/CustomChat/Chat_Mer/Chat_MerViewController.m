//
//  Chat_MerViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-11-20.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
////easepushview hidetab

#import "Chat_MerViewController.h"

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "SRRefreshView.h"
#import "DXChatBarMoreView.h"
#import "DXRecordView.h"
#import "DXFaceView.h"
#import "EMChatViewCell.h"
#import "EMChatTimeCell.h"
#import "ChatSendHelper.h"
#import "MessageReadManager.h"
#import "MessageModelManager.h"
#import "LocationViewController.h"
#import "ChatGroupDetailViewController.h"
#import "UIViewController+HUD.h"
#import "WCAlertView.h"
#import "NSDate+Category.h"
#import "DX_MerMessageToolBar.h"
#import "DXChatBarMoreView.h"
#import "CallViewController.h"

#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"
#define KPageCount 20
#import "ProductListViewController.h"
#import "ShopListViewController.h"
#import "AboutUsViewController.h"

#import "EMChatToHomeView.h"

@interface Chat_MerViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, SRRefreshDelegate, IChatManagerDelegate, DXChatBarMoreViewDelegate, DX_MerMessageToolBarDelegate, LocationViewDelegate, IDeviceManagerDelegate>
{
    UIMenuController *_menuController;
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    NSIndexPath *_longPressIndexPath;
    
    NSInteger _recordingCount;
    
    dispatch_queue_t _messageQueue;
    
    BOOL _isScrollToBottom;
    
    BOOL _isfuwei;//位置发生变化
}

@property (nonatomic) BOOL isChatGroup;
@property (strong, nonatomic) NSString *chatter;

@property (strong, nonatomic) NSMutableArray *dataSource;//tableView数据源
@property (strong, nonatomic) SRRefreshView *slimeView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DX_MerMessageToolBar *chatToolBar;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) MessageReadManager *messageReadManager;//message阅读的管理者
@property (strong, nonatomic) EMConversation *conversation;//会话管理者
@property (strong, nonatomic) NSDate *chatTagDate;

@property (nonatomic) BOOL isScrollToBottom;
@property (nonatomic) BOOL isPlayingAudio;

@property (nonatomic,strong) NSMutableDictionary *dataplist;//存储头像data的plist;


@end


@implementation Chat_MerViewController

- (instancetype)initWithChatter:(NSString *)chatter isGroup:(BOOL)isGroup
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _isPlayingAudio = NO;
        _chatter = chatter;
        _isChatGroup = isGroup;
        
        self.IDInfoCache = [[IDInfoCache alloc]init];
        self.ImageCache = [[ImageCache alloc]init];
        self.m_items = [[NSMutableDictionary alloc]init];
        self.m_merchantDic = [[NSMutableDictionary alloc]init];
        self.dataplist = [[NSMutableDictionary alloc]initWithCapacity:0];

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"MemberHeaderPhoto.plist"];
    self.dataplist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    _isfuwei = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Mer_BigAction:) name:@"Mer_BigAction" object:nil];
    self.m_MemberRelationsId = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MerchantShopId"]];
    
#warning 以下三行代码必须写，注册为SDK的ChatManager的delegate
    [[[EaseMob sharedInstance] deviceManager] addDelegate:self onQueue:nil];
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    //注册为SDK的ChatManager的delegate
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllMessages:) name:@"RemoveAllMessages" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGroup) name:@"ExitGroup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:@"applicationDidEnterBackground" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RemoveNullMessageConversation) name:@"RemoveNullMessageConversation" object:nil];

    _messageQueue = dispatch_queue_create("easemob.com", NULL);
    _isScrollToBottom = YES;
    
    [self setupBarButtonItem];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self.view addSubview:self.chatToolBar];
    
    //将self注册为chatToolBar的moreView的代理
    if ([self.chatToolBar.moreView isKindOfClass:[DXChatBarMoreView class]]) {
        [(DXChatBarMoreView *)self.chatToolBar.moreView setDelegate:self];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
    
    //通过会话管理者获取已收发消息
    [self loadMoreMessages];
    
    [self requestSubmit];
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:20]};
}

- (void)setupBarButtonItem
{
    
    if (_isChatGroup) {
        UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [detailButton setImage:[UIImage imageNamed:@"group_user"] forState:UIControlStateNormal];
        [detailButton addTarget:self action:@selector(showRoomContact:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    }
    else{
        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 25)];
        [clearButton setImage:[UIImage imageNamed:@"delete2"] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(removeAllMessages:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    }
}

-(void)RemoveNullMessageConversation
{
    //滑动返回清空记录
    //判断当前会话是否为空，若符合则删除该会话
    EMMessage *message = [_conversation latestMessage];
    if (message == nil) {
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:_conversation.chatter deleteMessages:YES append2Chat:NO];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isScrollToBottom) {
        [self scrollViewToBottom:YES];
    }
    else{
        _isScrollToBottom = YES;
    }
    
    
    if ( !_isfuwei ) {
        
        [self hideTabBar:YES];
        
    }else{
        
        // =========
//        if ( isIOS7 ) {
        
//            for(UIView *view in self.tabBarController.view.subviews)
//            {
//                
//                if([view isKindOfClass:[UITabBar class]])
//                {
//                    
//                    if (self.tabBarController.tabBar.hidden) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 0)];
//                    }
//                }
//            }
            
//        }
        //========
    }
    
    _isfuwei = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //关闭检测感应
    [[[EaseMob sharedInstance] deviceManager] disableProximitySensor];
    
    // 设置当前conversation的所有message为已读
    [_conversation markAllMessagesAsRead:YES];
    
    if ( !_isfuwei ) {
        
//        if ( isIOS7 ) {
        
            // 修改选择了图片后产生的bug =======
//            for(UIView *view in self.tabBarController.view.subviews)
//            {
//                
//                if([view isKindOfClass:[UITabBar class]])
//                {
//                    
//                    if (self.tabBarController.tabBar.hidden) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 49)];
//                        
//                    }
//                }
//                
//            }
//        }
        //=========
        
        [self hideTabBar:NO];
        
    }else{
        
    }
    
    [self.view endEditing:YES];

    
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView = nil;
    
    _slimeView.delegate = nil;
    _slimeView = nil;
    
    _chatToolBar.delegate = nil;
    _chatToolBar = nil;
    
    [[EaseMob sharedInstance].chatManager stopPlayingAudio];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#warning 以下第一行代码必须写，将self从ChatManager的代理中移除
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[[EaseMob sharedInstance] deviceManager] removeDelegate:self];
}

- (void)back
{
    //判断当前会话是否为空，若符合则删除该会话
    EMMessage *message = [_conversation latestMessage];
    if (message == nil) {
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:_conversation.chatter deleteMessages:YES append2Chat:NO];
        
    }

}

#pragma mark - helper
- (NSURL *)convert2Mp4:(NSURL *)movUrl {
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        mp4Url = [movUrl copy];
        mp4Url = [mp4Url URLByDeletingPathExtension];
        mp4Url = [mp4Url URLByAppendingPathExtension:@"mp4"];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        int timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (SRRefreshView *)slimeView
{
    if (_slimeView == nil) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
    }
    
    return _slimeView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.chatToolBar.frame.size.height) style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = .5;
        [_tableView addGestureRecognizer:lpgr];
    }
    
    return _tableView;
}

- (DX_MerMessageToolBar *)chatToolBar
{
    if (_chatToolBar == nil) {
        _chatToolBar = [[DX_MerMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [DX_MerMessageToolBar defaultHeight], self.view.frame.size.width , [DX_MerMessageToolBar defaultHeight])];
        _chatToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        _chatToolBar.delegate = self;
        
        ChatMoreType type = _isChatGroup == YES ? ChatMoreTypeGroupChat : ChatMoreTypeChat;
        _chatToolBar.moreView = [[DXChatBarMoreView alloc] initWithFrame:CGRectMake(0, (kVerticalPadding * 2 + kInputTextViewMinHeight), _chatToolBar.frame.size.width , 80) typw:type];
        _chatToolBar.moreView.backgroundColor = [UIColor lightGrayColor];
        _chatToolBar.moreView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _chatToolBar;
}

- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}

- (MessageReadManager *)messageReadManager
{
    if (_messageReadManager == nil) {
        _messageReadManager = [MessageReadManager defaultManager];
    }
    
    return _messageReadManager;
}

- (NSDate *)chatTagDate
{
    if (_chatTagDate == nil) {
        _chatTagDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:0];
    }
    
    return _chatTagDate;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        id obj = [self.dataSource objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[NSString class]]) {
            EMChatTimeCell *timeCell = (EMChatTimeCell *)[tableView dequeueReusableCellWithIdentifier:@"MessageCellTime"];
            if (timeCell == nil) {
                timeCell = [[EMChatTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCellTime"];
                timeCell.backgroundColor = [UIColor clearColor];
                timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            timeCell.textLabel.text = (NSString *)obj;
            
            return timeCell;
        }
        else{
            MessageModel *model = (MessageModel *)obj;
            NSString *cellIdentifier = [EMChatViewCell cellIdentifierForMessageModel:model];
            EMChatViewCell *cell = (EMChatViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[EMChatViewCell alloc] initWithMessageModel:model reuseIdentifier:cellIdentifier];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.messageModel = model;
            
            NSLog(@"messageModel.isSender = %i",cell.messageModel.isSender);
            
            if (cell.messageModel.isSender) {
                if ([self.dataplist objectForKey:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]]]!=nil) {
                    cell.headImageView.image = [UIImage imageWithData:[self.dataplist objectForKey:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]]]];
                    
                }else
                {
                    [cell.headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]]] placeholderImage:[UIImage imageNamed:@"moren.png"]];
                    
                }
            }else
            {
                if (_isChatGroup)
                {
                    if ([self ISnullInfo:model.username]) {
                        NSString * NickName = [NSString stringWithFormat:@"%@",[[self.IDInfoCache getInfo:model.username] objectForKey:@"NickName"]];
                        cell.nameLabel.text = NickName;
                        NSString * imagePath = [NSString stringWithFormat:@"%@",[[self.IDInfoCache getInfo:model.username] objectForKey:@"PhotoMidUrl"]];
                        UIImage *reSizeImage = [self.ImageCache getImage:imagePath];
                        if (reSizeImage != nil) {
                            cell.headImageView.image = reSizeImage;
                        }else
                        {
//                            [cell.headImageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
//                                                      placeholderImage:[UIImage imageNamed:@"moren.png"]
//                                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                                                   cell.headImageView.image = image;
//                                                                   cell.headImageView.contentMode = UIViewContentModeScaleAspectFit;
//                                                                   [self.ImageCache addImage:image andUrl:imagePath];
//                                                               }
//                                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                                                   
//                                                                   cell.headImageView.image = [UIImage imageNamed:@"moren.png"];
//                                                                   
//                                                               }];
                            [cell.headImageView setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"moren.png"]];
                            
                        }
                        
                    }else{
                        
                        NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
                        NSString *key = [CommonUtil getServerKey];
                        AppHttpClient* httpClient = [AppHttpClient sharedClient];
                        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                               memberId,     @"memberId",
                                               key,   @"key",
                                               model.username,@"otherId",
                                               nil];
                        [httpClient request:@"FriendsDetail.ashx" parameters:param success:^(NSJSONSerialization* json){
                            BOOL success = [[json valueForKey:@"status"] boolValue];
                            if (success) {
                                NSDictionary * DIC = [json valueForKey:@"friendsInfo"];
                                [self.IDInfoCache addInfo:[json valueForKey:@"friendsInfo"] andID:model.username];
                                NSString * NickName = [NSString stringWithFormat:@"%@",[DIC objectForKey:@"NickName"]];
//                                [cell.headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[DIC objectForKey:@"PhotoMidUrl"]]]];
                                [cell.headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[DIC objectForKey:@"PhotoMidUrl"]]] placeholderImage:[UIImage imageNamed:@"moren.png"]];

                                cell.nameLabel.text = NickName;
                            }
                        } failure:^(NSError *error) {
                            
                        }];
                    }
                    
                }else
                {
                    cell.headImageView.image = self.Uimage;
                }
                
            }
            
            return cell;
        }
    }
    
    return nil;
}

#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        return 40;
    }
    else{
        return [EMChatViewCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:(MessageModel *)obj];
    }
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_slimeView) {
        [_slimeView scrollViewDidScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_slimeView) {
        [_slimeView scrollViewDidEndDraging];
    }
}

#pragma mark - slimeRefresh delegate
//加载更多
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self loadMoreMessages];
    [_slimeView endRefresh];
}

#pragma mark - GestureRecognizer

// 点击背景隐藏
-(void)keyBoardHidden
{
    [self.chatToolBar endEditing:YES];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan && [self.dataSource count] > 0) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        id object = [self.dataSource objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[MessageModel class]]) {
            EMChatViewCell *cell = (EMChatViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell becomeFirstResponder];
            _longPressIndexPath = indexPath;
            [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.messageModel.type];
        }
    }
}

#pragma mark - UIResponder actions

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    MessageModel *model = [userInfo objectForKey:KMESSAGEKEY];
    if ([eventName isEqualToString:kRouterEventTextURLTapEventName]) {
        [self chatTextCellUrlPressed:[userInfo objectForKey:@"url"]];
    }
    else if ([eventName isEqualToString:kRouterEventAudioBubbleTapEventName]) {
        [self chatAudioCellBubblePressed:model];
    }
    else if ([eventName isEqualToString:kRouterEventImageBubbleTapEventName]){
        [self chatImageCellBubblePressed:model];
    }
    else if ([eventName isEqualToString:kRouterEventLocationBubbleTapEventName]){
        [self chatLocationCellBubblePressed:model];
    }
    else if([eventName isEqualToString:kResendButtonTapEventName]){
        EMChatViewCell *resendCell = [userInfo objectForKey:kShouldResendCell];
        MessageModel *messageModel = resendCell.messageModel;
        messageModel.status = eMessageDeliveryState_Delivering;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:resendCell];
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
        id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
        [chatManager asyncResendMessage:messageModel.message progress:nil];
    }else if([eventName isEqualToString:kRouterEventChatCellVideoTapEventName]){
        [self chatVideoCellPressed:model];
        
    }
    
}

//链接被点击
- (void)chatTextCellUrlPressed:(NSURL *)url
{
    if (url) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

// 语音的bubble被点击
-(void)chatAudioCellBubblePressed:(MessageModel *)model
{
    id <IEMFileMessageBody> body = [model.message.messageBodies firstObject];
    EMAttachmentDownloadStatus downloadStatus = [body attachmentDownloadStatus];
    if (downloadStatus == EMAttachmentDownloading) {
        [self showHint:@"正在下载语音，稍后点击"];
        return;
    }
    else if (downloadStatus == EMAttachmentDownloadFailure)
    {
        [self showHint:@"正在下载语音，稍后点击"];
        [[EaseMob sharedInstance].chatManager asyncFetchMessage:model.message progress:nil];
        
        return;
    }
    
    // 播放音频
    if (model.type == eMessageBodyType_Voice) {
        __weak Chat_MerViewController *weakSelf = self;
        BOOL isPrepare = [self.messageReadManager prepareMessageAudioModel:model updateViewCompletion:^(MessageModel *prevAudioModel, MessageModel *currentAudioModel) {
            if (prevAudioModel || currentAudioModel) {
                [weakSelf.tableView reloadData];
            }
        }];
        
        if (isPrepare) {
            _isPlayingAudio = YES;
            __weak Chat_MerViewController *weakSelf = self;
            [[[EaseMob sharedInstance] deviceManager] enableProximitySensor];
            [[EaseMob sharedInstance].chatManager asyncPlayAudio:model.chatVoice completion:^(EMError *error) {
                [weakSelf.messageReadManager stopMessageAudioModel];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                    
                    weakSelf.isPlayingAudio = NO;
                });
            } onQueue:nil];
        }
        else{
            _isPlayingAudio = NO;
        }
    }
}

// 位置的bubble被点击
-(void)chatLocationCellBubblePressed:(MessageModel *)model
{
    _isScrollToBottom = NO;
    LocationViewController *locationController = [[LocationViewController alloc] initWithLocation:CLLocationCoordinate2DMake(model.latitude, model.longitude)];
    _isfuwei = NO;
    [self.navigationController pushViewController:locationController animated:YES];
}

- (void)chatVideoCellPressed:(MessageModel *)model{
    
    __weak Chat_MerViewController *weakSelf = self;
    id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
    [weakSelf showHudInView:weakSelf.view hint:@"正在获取视频..."];
    [chatManager asyncFetchMessage:model.message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
        [weakSelf hideHud];
        if (!error) {
            _isfuwei = YES;
            NSString *localPath = aMessage == nil ? model.localPath : [[aMessage.messageBodies firstObject] localPath];
            if (localPath && localPath.length > 0) {
                [weakSelf playVideoWithVideoPath:localPath];
            }
        }else{
            [weakSelf showHint:@"视频获取失败!"];
        }
    } onQueue:nil];
}

- (void)playVideoWithVideoPath:(NSString *)videoPath
{
    _isScrollToBottom = NO;
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    [moviePlayerController.moviePlayer prepareToPlay];
    moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [self presentMoviePlayerViewControllerAnimated:moviePlayerController];
}

// 图片的bubble被点击
-(void)chatImageCellBubblePressed:(MessageModel *)model
{
    __weak Chat_MerViewController *weakSelf = self;
    id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
    if ([model.messageBody messageBodyType] == eMessageBodyType_Image) {
        EMImageMessageBody *imageBody = (EMImageMessageBody *)model.messageBody;
        if (imageBody.thumbnailDownloadStatus == EMAttachmentDownloadSuccessed) {
            [weakSelf showHudInView:weakSelf.view hint:@"正在获取大图..."];
            [chatManager asyncFetchMessage:model.message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
                [weakSelf hideHud];
                if (!error) {
                    _isfuwei = YES;
                    NSString *localPath = aMessage == nil ? model.localPath : [[aMessage.messageBodies firstObject] localPath];
                    if (localPath && localPath.length > 0) {
                        NSURL *url = [NSURL fileURLWithPath:localPath];
                        weakSelf.isScrollToBottom = NO;
                        [weakSelf.messageReadManager showBrowserWithImages:@[url]];
                        return ;
                    }
                }
                [weakSelf showHint:@"大图获取失败!"];
            } onQueue:nil];
        }else{
            //获取缩略图
            [chatManager asyncFetchMessageThumbnail:model.message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
                if (!error) {
                    [weakSelf reloadTableViewDataWithMessage:model.message];
                }else{
                    [weakSelf showHint:@"缩略图获取失败!"];
                }
                
            } onQueue:nil];
        }
    }else if ([model.messageBody messageBodyType] == eMessageBodyType_Video) {
        //获取缩略图
        EMVideoMessageBody *videoBody = (EMVideoMessageBody *)model.messageBody;
        if (videoBody.thumbnailDownloadStatus != EMAttachmentDownloadSuccessed) {
            [chatManager asyncFetchMessageThumbnail:model.message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
                if (!error) {
                    [weakSelf reloadTableViewDataWithMessage:model.message];
                }else{
                    [weakSelf showHint:@"缩略图获取失败!"];
                }
            } onQueue:nil];
        }
    }
}

#pragma mark - IChatManagerDelegate

-(void)didSendMessage:(EMMessage *)message error:(EMError *)error;
{
    [self reloadTableViewDataWithMessage:message];
}

- (void)reloadTableViewDataWithMessage:(EMMessage *)message{
    __weak Chat_MerViewController *weakSelf = self;
    dispatch_async(_messageQueue, ^{
        if ([weakSelf.conversation.chatter isEqualToString:message.conversationChatter])
        {
            for (int i = 0; i < weakSelf.dataSource.count; i ++) {
                id object = [weakSelf.dataSource objectAtIndex:i];
                if ([object isKindOfClass:[MessageModel class]]) {
                    EMMessage *currMsg = [weakSelf.dataSource objectAtIndex:i];
                    if ([message.messageId isEqualToString:currMsg.messageId]) {
                        MessageModel *cellModel = [MessageModelManager modelWithMessage:message];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf.tableView beginUpdates];
                            [weakSelf.dataSource replaceObjectAtIndex:i withObject:cellModel];
                            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                            [weakSelf.tableView endUpdates];
                            
                        });
                        
                        break;
                    }
                }
            }
        }
    });
}

- (void)didMessageAttachmentsStatusChanged:(EMMessage *)message error:(EMError *)error{
    if (!error) {
        id<IEMFileMessageBody>fileBody = (id<IEMFileMessageBody>)[message.messageBodies firstObject];
        if ([fileBody messageBodyType] == eMessageBodyType_Image) {
            EMImageMessageBody *imageBody = (EMImageMessageBody *)fileBody;
            if ([imageBody thumbnailDownloadStatus] == EMAttachmentDownloadSuccessed)
            {
                [self reloadTableViewDataWithMessage:message];
            }
        }else if([fileBody messageBodyType] == eMessageBodyType_Video){
            EMVideoMessageBody *videoBody = (EMVideoMessageBody *)fileBody;
            if ([videoBody thumbnailDownloadStatus] == EMAttachmentDownloadSuccessed)
            {
                [self reloadTableViewDataWithMessage:message];
            }
        }else if([fileBody messageBodyType] == eMessageBodyType_Voice){
            if ([fileBody attachmentDownloadStatus] == EMAttachmentDownloadSuccessed)
            {
                [self reloadTableViewDataWithMessage:message];
            }
        }
        
    }else{
        
    }
}

- (void)didFetchingMessageAttachments:(EMMessage *)message progress:(float)progress{
    NSLog(@"didFetchingMessageAttachment: %f", progress);
}

-(void)didReceiveMessage:(EMMessage *)message
{
    if ([_conversation.chatter isEqualToString:message.conversationChatter]) {
        [self addChatDataToMessage:message];
    }
}

- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error
{
    if (_isChatGroup && [group.groupId isEqualToString:_chatter]) {
        [self.navigationController popToViewController:self animated:NO];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)didInterruptionRecordAudio
{
    [_chatToolBar cancelTouchRecord];
    
    // 设置当前conversation的所有message为已读
    [_conversation markAllMessagesAsRead:YES];
    
    [self stopAudioPlaying];
}

#pragma mark - EMChatBarMoreViewDelegate

- (void)moreViewPhotoAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    
    // 弹出照片选择
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    _isfuwei = YES;
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
    
}

- (void)moreViewTakePicAction:(DXChatBarMoreView *)moreView
{
    [self keyBoardHidden];
    
#if TARGET_IPHONE_SIMULATOR
    [self showHint:@"模拟器不支持拍照"];
#elif TARGET_OS_IPHONE
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    _isfuwei = YES;
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
    
#endif
}

- (void)moreViewLocationAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    
    LocationViewController *locationController = [[LocationViewController alloc] initWithNibName:nil bundle:nil];
    locationController.delegate = self;
    _isfuwei = NO;
    [self.navigationController pushViewController:locationController animated:YES];
    
}

- (void)moreViewVideoAction:(DXChatBarMoreView *)moreView{
    [self keyBoardHidden];
    
#if TARGET_IPHONE_SIMULATOR
    [self showHint:@"模拟器不支持录像"];
#elif TARGET_OS_IPHONE
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
    _isfuwei = YES;
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
    
#endif
}

- (void)moreViewAudioCallAction:(DXChatBarMoreView *)moreView
{
    CallViewController *callController = [CallViewController shareController];
    [callController setupCallOutWithChatter:_chatter];
    //    [callController setupCallInWithChatter:_chatter];
    _isfuwei = YES;
    [self presentViewController:callController animated:YES completion:nil];
    
}

#pragma mark - LocationViewDelegate

-(void)sendLocationLatitude:(double)latitude longitude:(double)longitude andAddress:(NSString *)address
{
    EMMessage *locationMessage = [ChatSendHelper sendLocationLatitude:latitude longitude:longitude address:address toUsername:_conversation.chatter isChatGroup:_isChatGroup requireEncryption:NO];
    [self addChatDataToMessage:locationMessage];
}

#pragma mark - DX_MerMessageToolBarDelegate
- (void)inputTextViewWillBeginEditing:(XHMessageTextView *)messageInputTextView{
    [_menuController setMenuItems:nil];
    
    //    [self hiddenNumPadDone:nil];
}
- (void)didChangeFrameToHeight:(CGFloat)toHeight
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        rect.origin.y = 0;
        rect.size.height = self.view.frame.size.height - toHeight;
        self.tableView.frame = rect;
    }];
    [self scrollViewToBottom:YES];
}
- (void)didfdeFrameToHeight:(CGFloat)toHeight
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        rect.origin.y = 0;
        rect.size.height = self.view.frame.size.height - toHeight;
        self.tableView.frame = rect;
    }];
    [self scrollViewToBottom:YES];
}

- (void)didSendText:(NSString *)text
{
    if (text && text.length > 0) {
        [self sendTextMessage:text];
    }
}

/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction:(UIView *)recordView
{
    //    if (_isRecording) {
    //        ++_recordingCount;
    //        if (_recordingCount > 10)
    //        {
    //            _recordingCount = 0;
    //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，已经戳漏了，随时崩溃给你看" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //            [alertView show];
    //        }
    //        else if (_recordingCount > 5) {
    //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，手别抖了，快被戳漏了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //            [alertView show];
    //        }
    //        return;
    //    }
    //    _isRecording = YES;
    
    DXRecordView *tmpView = (DXRecordView *)recordView;
    tmpView.center = self.view.center;
    [self.view addSubview:tmpView];
    [self.view bringSubviewToFront:recordView];
    
    NSError *error = nil;
    [[EaseMob sharedInstance].chatManager startRecordingAudioWithError:&error];
    if (error) {
        NSLog(@"开始录音失败");
    }
}

/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction:(UIView *)recordView
{
    [[EaseMob sharedInstance].chatManager asyncCancelRecordingAudioWithCompletion:nil onQueue:nil];
}

/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction:(UIView *)recordView
{
    [[EaseMob sharedInstance].chatManager
     asyncStopRecordingAudioWithCompletion:^(EMChatVoice *aChatVoice, NSError *error){
         if (!error) {
             [self sendAudioMessage:aChatVoice];
         }else{
             if (error.code == EMErrorAudioRecordNotStarted) {
                 [self showHint:error.domain yOffset:-40];
             } else {
                 [self showHint:error.domain];
             }
         }
         
     } onQueue:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        [picker dismissViewControllerAnimated:YES completion:nil];
        // video url:
        // file:///private/var/mobile/Applications/B3CDD0B2-2F19-432B-9CFA-158700F4DE8F/tmp/capture-T0x16e39100.tmp.9R8weF/capturedvideo.mp4
        // we will convert it to mp4 format
        NSURL *mp4 = [self convert2Mp4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                NSLog(@"failed to remove file, error:%@.", error);
            }
        }
        EMChatVideo *chatVideo = [[EMChatVideo alloc] initWithFile:[mp4 relativePath] displayName:@"video.mp4"];
        [self sendVideoMessage:chatVideo];
        
    }else{
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self sendImageMessage:orgImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MenuItem actions

- (void)copyMenuAction:(id)sender
{
    // todo by du. 复制
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (_longPressIndexPath.row > 0) {
        MessageModel *model = [self.dataSource objectAtIndex:_longPressIndexPath.row];
        pasteboard.string = model.content;
    }
    
    _longPressIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (_longPressIndexPath && _longPressIndexPath.row > 0) {
        MessageModel *model = [self.dataSource objectAtIndex:_longPressIndexPath.row];
        NSMutableArray *messages = [NSMutableArray arrayWithObjects:model, nil];
        [_conversation removeMessageWithId:model.messageId];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:_longPressIndexPath, nil];;
        if (_longPressIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataSource objectAtIndex:(_longPressIndexPath.row - 1)];
            if (_longPressIndexPath.row + 1 < [self.dataSource count]) {
                nextMessage = [self.dataSource objectAtIndex:(_longPressIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [messages addObject:prevMessage];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(_longPressIndexPath.row - 1) inSection:0]];
            }
        }
        [self.dataSource removeObjectsInArray:messages];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    
    _longPressIndexPath = nil;
}

#pragma mark - private

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bCanRecord;
}

- (void)stopAudioPlaying
{
    //停止音频播放及播放动画
    [[EaseMob sharedInstance].chatManager stopPlayingAudio];
    MessageModel *playingModel = [self.messageReadManager stopMessageAudioModel];
    
    NSIndexPath *indexPath = nil;
    if (playingModel) {
        indexPath = [NSIndexPath indexPathForRow:[self.dataSource indexOfObject:playingModel] inSection:0];
    }
    
    if (indexPath) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        });
    }
}

- (void)loadMoreMessages
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(_messageQueue, ^{
        NSInteger currentCount = [weakSelf.dataSource count];
        EMMessage *latestMessage = [weakSelf.conversation latestMessage];
        NSTimeInterval beforeTime = 0;
        if (latestMessage) {
            beforeTime = latestMessage.timestamp + 1;
        }else{
            beforeTime = [[NSDate date] timeIntervalSince1970] * 1000 + 1;
        }
        
        NSArray *chats = [weakSelf.conversation loadNumbersOfMessages:(currentCount + KPageCount) before:beforeTime];
        
        if ([chats count] > currentCount) {
            weakSelf.dataSource.array = [weakSelf sortChatSource:chats];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                
                [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[weakSelf.dataSource count] - currentCount - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            });
        }
    });
}

- (NSArray *)sortChatSource:(NSArray *)array
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if (array && [array count] > 0) {
        
        for (EMMessage *message in array) {
            NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
            NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
            if (tempDate > 60 || tempDate < -60 || (self.chatTagDate == nil)) {
                [resultArray addObject:[createDate formattedTime]];
                self.chatTagDate = createDate;
            }
            
            MessageModel *model = [MessageModelManager modelWithMessage:message];
            if (model) {
                [resultArray addObject:model];
            }
        }
    }
    
    return resultArray;
}

-(NSMutableArray *)addChatToMessage:(EMMessage *)message
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
    NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
    if (tempDate > 60 || tempDate < -60 || (self.chatTagDate == nil)) {
        [ret addObject:[createDate formattedTime]];
        self.chatTagDate = createDate;
    }
    
    MessageModel *model = [MessageModelManager modelWithMessage:message];
    if (model) {
        [ret addObject:model];
    }
    
    return ret;
}

-(void)addChatDataToMessage:(EMMessage *)message
{
    __weak Chat_MerViewController *weakSelf = self;
    dispatch_async(_messageQueue, ^{
        NSArray *messages = [weakSelf addChatToMessage:message];
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < messages.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:weakSelf.dataSource.count+i inSection:0];
            //            [indexPaths insertObject:indexPath atIndex:0];
            [indexPaths addObject:indexPath];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView beginUpdates];
            [weakSelf.dataSource addObjectsFromArray:messages];
            [weakSelf.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.tableView endUpdates];
            
            //            [weakSelf.tableView reloadData];
            
            [weakSelf.tableView scrollToRowAtIndexPath:[indexPaths lastObject] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        });
    });
}

- (void)scrollViewToBottom:(BOOL)animated
{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:YES];
    }
}

- (void)showRoomContact:(id)sender
{
    [self.view endEditing:YES];
    if (_isChatGroup) {
        ChatGroupDetailViewController *detailController = [[ChatGroupDetailViewController alloc] initWithGroupId:_chatter];
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (void)removeAllMessages:(id)sender
{
    if (_conversation.latestMessage == nil) {
        [self showHint:@"消息已经清空"];
        return;
    }
    
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSString *groupId = (NSString *)[(NSNotification *)sender object];
        if (_isChatGroup && [groupId isEqualToString:_conversation.chatter]) {
            [_conversation removeAllMessages];
            [_dataSource removeAllObjects];
            [_tableView reloadData];
            [self showHint:@"消息已经清空"];
        }
    }
    else{
        __weak typeof(self) weakSelf = self;
        [WCAlertView showAlertWithTitle:@"提示"
                                message:@"请确认删除"
                     customizationBlock:^(WCAlertView *alertView) {
                         
                     } completionBlock:
         ^(NSUInteger buttonIndex, WCAlertView *alertView) {
             if (buttonIndex == 1) {
                 [weakSelf.conversation removeAllMessages];
                 [weakSelf.dataSource removeAllObjects];
                 [weakSelf.tableView reloadData];
             }
         } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
}

- (void)showMenuViewController:(UIView *)showInView andIndexPath:(NSIndexPath *)indexPath messageType:(MessageBodyType)messageType
{
    if (_menuController == nil) {
        _menuController = [UIMenuController sharedMenuController];
    }
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMenuAction:)];
    }
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMenuAction:)];
    }
    
    if (messageType == eMessageBodyType_Text) {
        [_menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem]];
    }
    else{
        [_menuController setMenuItems:@[_deleteMenuItem]];
    }
    
    [_menuController setTargetRect:showInView.frame inView:showInView.superview];
    [_menuController setMenuVisible:YES animated:YES];
}

- (void)exitGroup
{
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)applicationDidEnterBackground
{
    [_chatToolBar cancelTouchRecord];
    
    // 设置当前conversation的所有message为已读
    [_conversation markAllMessagesAsRead:YES];
}

#pragma mark - send message

-(void)sendTextMessage:(NSString *)textMessage
{
    //    for (int i = 0; i < 100; i++) {
    //        NSString *str = [NSString stringWithFormat:@"%@--%i", _conversation.chatter, i];
    //        EMMessage *tempMessage = [ChatSendHelper sendTextMessageWithString:str toUsername:_conversation.chatter isChatGroup:_isChatGroup requireEncryption:NO];
    //        [self addChatDataToMessage:tempMessage];
    //    }
    EMMessage *tempMessage = [ChatSendHelper sendTextMessageWithString:textMessage toUsername:_conversation.chatter isChatGroup:_isChatGroup requireEncryption:NO];
    [self addChatDataToMessage:tempMessage];
}

-(void)sendImageMessage:(UIImage *)imageMessage
{
    EMMessage *tempMessage = [ChatSendHelper sendImageMessageWithImage:imageMessage toUsername:_conversation.chatter isChatGroup:_isChatGroup requireEncryption:NO];
    [self addChatDataToMessage:tempMessage];
}

-(void)sendAudioMessage:(EMChatVoice *)voice
{
    EMMessage *tempMessage = [ChatSendHelper sendVoice:voice toUsername:_conversation.chatter isChatGroup:_isChatGroup requireEncryption:NO];
    [self addChatDataToMessage:tempMessage];
}

-(void)sendVideoMessage:(EMChatVideo *)video
{
    EMMessage *tempMessage = [ChatSendHelper sendVideo:video toUsername:_conversation.chatter isChatGroup:_isChatGroup requireEncryption:NO];
    [self addChatDataToMessage:tempMessage];
}

#pragma mark - EMDeviceManagerProximitySensorDelegate

- (void)proximitySensorChanged:(BOOL)isCloseToUser{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if (isCloseToUser)//黑屏
    {
        // 使用耳机播放
        [[EaseMob sharedInstance].deviceManager switchAudioOutputDevice:eAudioOutputDevice_earphone];
    } else {
        // 使用扬声器播放
        [[EaseMob sharedInstance].deviceManager switchAudioOutputDevice:eAudioOutputDevice_speaker];
        if (!_isPlayingAudio) {
            [[[EaseMob sharedInstance] deviceManager] disableProximitySensor];
        }
    }
}

//判断根据ID的个人信息是否为空
-(BOOL)ISnullInfo:(NSString *)ID{
    NSMutableDictionary *reSizeInfo = [self.IDInfoCache getInfo:ID];
    if (reSizeInfo != nil) {
        return YES;
    }return NO;
}

- (void) hideTabBar:(BOOL) hidden{
//    if ( isIOS7 ) {
//        [self.tabBarController.tabBar setHidden:hidden];
//        for(UIView *view in self.tabBarController.view.subviews)
//        {
//            CGSize m_size = self.tabBarController.view.frame.size;
//            if([view isKindOfClass:[UITabBar class]])
//            {
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width,m_size.height + 49);
//                } else {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height-49, view.frame.size.width, view.frame.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height+ 49);
//                }
//            }
//            else
//            {
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
//                } else {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height-98)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
//                }
//            }
//        }
//        
//    }else{
//        
//        if ( [self.tabBarController.view.subviews count] < 2 )
//        {
//            return;
//        }
//        UIView *contentView;
//        
//        if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
//            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
//        }
//        else{
//            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
//        }
//        if ( hidden ){
//            contentView.frame = self.tabBarController.view.bounds;
//        }
//        else
//        {
//            contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
//                                           self.tabBarController.view.bounds.origin.y,
//                                           self.tabBarController.view.bounds.size.width,
//                                           self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height + 49);
//        }
//        self.tabBarController.tabBar.hidden = hidden;
//    }
}

-(void)Mer_BigAction:(id)sender
{
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSString *tag = (NSString *)[(NSNotification *)sender object];
    //1.进入商品列表
    //2. 进入店铺列表
    //3. 进入关于我们的页面
        if ([tag isEqualToString:@"1"]) {
            // 进入商品列表
            ProductListViewController *VC = [[ProductListViewController alloc]initWithNibName:@"ProductListViewController" bundle:nil];
            VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]];
            VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MerchantShopId"]];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([tag isEqualToString:@"2"])
        {
            // 进入店铺列表
            ShopListViewController *VC = [[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
            VC.m_typeString = @"2";
            VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([tag isEqualToString:@"3"])
        {
            // 进入关于我们的页面
            AboutUsViewController *VC = [[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
            VC.m_dic = self.m_merchantDic;
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];
            
        }

    }
}


// 请求数据
- (void)requestSubmit{
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSString stringWithFormat:@"%@",self.m_MemberRelationsId],   @"merchantShopId",
                                  memberId,@"memberId",
                                  nil];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [httpClient request:@"MerchantDescription_0.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            self.m_merchantDic = [json valueForKey:@"Merchant"];
                        
            self.title = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"NickName"]];
            _chatter = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"MemberId"]];
            
            //根据接收者的username获取当前会话的管理者
            _conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:_chatter isGroup:_isChatGroup];
            
            // 导航栏上面的标题
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
            view.backgroundColor = [UIColor clearColor];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 7, 30, 30)];
            imageV.layer.cornerRadius = 15.0f;
            imageV.layer.borderWidth = 1.0f;
            imageV.layer.borderColor = [UIColor clearColor].CGColor;
            imageV.layer.masksToBounds = YES;
            
            // 获取图片
            NSString *path = [self.m_merchantDic objectForKey:@"PhotoMidUrl"];
//            [imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
//                          placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
//                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                       imageV.image = image;
//                                       self.Uimage = imageV.image;
//                                   }
//                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                       
//                                   }];
            
            [imageV setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
            UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14, 10, 16)];
            imgV.image = [UIImage imageNamed:@"arrow_WL.png"];
            UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
            [_button setFrame:CGRectMake(0, 0, 60, 44)];
            _button.backgroundColor = [UIColor clearColor];
            [_button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:imgV];
            [view addSubview:imageV];
            [view addSubview:_button];
            UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:view];
            [self.navigationItem setLeftBarButtonItem:_barButton];

        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)goBack{
    
    [self back];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
