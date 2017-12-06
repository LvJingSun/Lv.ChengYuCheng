//
//  SendMessageViewController.h
//  HuiHui
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "Userobject.h"

#import "MoreView.h"

#import <AVFoundation/AVFoundation.h>

#import <AudioToolbox/AudioToolbox.h>

#import "RecordAudio.h"

#import "MessageListCell.h"

#import "EmotionView.h"


@interface Send_merchantViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MoreviewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate,RecordAudioDelegate,LongPressGestureDelegate>{
    
    
    AVAudioPlayer       *player;
    
    RecordAudio         *recordAudio;
    
    SystemSoundID       beepSound;

}

@property (nonatomic, strong)   NSURL *soundToPlay;


@property (nonatomic, strong) Userobject        *m_chatPerson;

@property (nonatomic, strong) NSMutableArray    *m_recordList;

@property (nonatomic, assign) BOOL              isSelectedPicture;
// 拍照、相册的view
@property (nonatomic, strong) MoreView          *m_moreView;
// 表情所在的view
@property (nonatomic, strong) EmotionView       *m_emotionView;

@property (nonatomic, retain) AVAudioRecorder   *m_recorder;

@property (nonatomic, retain) NSString          *m_recorderFilePath;

@property (nonatomic, retain) NSData            *m_dataFile;
// 判断是否录音的BOOL值
@property (nonatomic, assign) BOOL              m_prepareToRecord;


// 判断是否点击了录音的按钮 是录音模式还是键盘模式
@property (nonatomic, assign) BOOL              isVoiceMode;

// 播放语音显示的动画效果
@property (nonatomic, strong) UIImageView       *m_imageView;

@property (nonatomic, assign) BOOL              isFirstInPage;

// 记录选中的是某一行的录音
@property (nonatomic, assign) NSInteger         m_index;

@property (nonatomic, strong) NSTimer           *mEndTimer;

@property (nonatomic, assign) NSTimeInterval    m_Second;

// 记录长按的是哪一行，用于复制，删除和转发
@property (nonatomic, assign) NSInteger         m_longIndex;

@property (nonatomic, strong) NSMutableDictionary *m_items;

@property (nonatomic, strong) NSString              *m_MemberRelationsId;
@property (nonatomic, strong) NSMutableDictionary   *m_merchantDic;


// 记录来自于哪个页面  1表示来自于商户列表显示右上角的关注按钮  2表示其他的地方
@property (nonatomic, strong) NSString              *m_typeString;
// 记录是来自消息页面 1 还是其他的页面 2，如商户列表，我关注的商户页面
@property (nonatomic, strong) NSString              *m_xiaoxiString;

// 转发来进行的一些操作
- (void)forwardClicked;

// 将表情字符转换成可以识别到的字符
- (NSString *) toCoreText:(NSString *)text;

@end
