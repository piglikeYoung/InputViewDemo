//
//  JHEmotionKeyboard.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/9.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHEmotionKeyboard.h"
#import "JHEmotionListView.h"
#import "JHEmotionToolbar.h"
//#import "MJExtension.h"
#import "JHEmotionTool.h"
#import "UIView+Extension.h"


@interface JHEmotionKeyboard() <JHEmotionToolbarDelegate>

/** 表情列表 */
@property (nonatomic, weak) JHEmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) JHEmotionToolbar *toollbar;

@end

@implementation JHEmotionKeyboard

+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        // 1.添加表情列表
        JHEmotionListView *listView = [[JHEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        JHEmotionToolbar *toollbar = [[JHEmotionToolbar alloc] init];
        toollbar.delegate = self;// 设置代理时，去调用默认选中“默认”按钮方法
        [self addSubview:toollbar];
        self.toollbar = toollbar;
    }
    
    return self;
}





- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条的frame
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toollbar.y;
    
}

#pragma mark - JHEmotionToolbarDelegate
- (void)emotionToolbar:(JHEmotionToolbar *)toolbar didSelectedButton:(JHEmotionType)emotionType
{
    switch (emotionType) {
        case JHEmotionTypeDefault:// 默认
            self.listView.emotions = [JHEmotionTool defaultEmotions];
            break;
            
        case JHEmotionTypeEmoji: // Emoji
            self.listView.emotions = [JHEmotionTool emojiEmotions];
            break;
            
        case JHEmotionTypeLxh: // 浪小花
            self.listView.emotions = [JHEmotionTool lxhEmotions];
            break;
            
        case JHEmotionTypeRecent:// 最近
            self.listView.emotions = [JHEmotionTool recentEmotions];
            break;
    }
    
}


@end
