//
//  JHEmotionGridView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/10.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHEmotionGridView.h"
#import "JHEmotion.h"
#import "JHEmotionView.h"
#import "JHEmotionPopView.h"
#import "JHEmotionTool.h"
#import "JHMacro.h"
#import "UIView+Extension.h"

@interface JHEmotionGridView()

@property (nonatomic, weak) UIButton *deleteButton;
/** 存放每个表情按钮，方便排列表情， 否则利用subView取出排列的第一个button是删除按钮 */
@property (nonatomic, strong) NSMutableArray *emotionViews;

@property (strong , nonatomic) JHEmotionPopView *popView;

@end

@implementation JHEmotionGridView


-(JHEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [JHEmotionPopView popView];
    }
    
    return _popView;
}

- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 给自己添加一个长按手势识别器
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
    
    return self;
}

/**
 *  根据触摸点返回对应的表情控件
 */
- (JHEmotionView *)emotionViewWithPoint:(CGPoint)point
{
    __block JHEmotionView *foundEmotionView = nil;
    // 遍历数组里的每个元素
    [self.emotionViews enumerateObjectsUsingBlock:^(JHEmotionView *emotionView, NSUInteger idx, BOOL *stop) {
        // 判断在哪个JHEmotionView范围内
        if (CGRectContainsPoint(emotionView.frame, point) && emotionView.hidden == NO) {
            foundEmotionView = emotionView;
            // 停止便利
            *stop = YES;
        }
    }];
    
    return foundEmotionView;
}


/**
 *  触发了长按手势
 */
- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    // 1.获取触摸点
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    // 2.检测触摸点落到哪个表情上
    JHEmotionView *emotionView = [self emotionViewWithPoint:point];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) { // 手松开了
        // 移除表情弹出控件
        [self.popView dismiss];
        
        // 选中表情
        [self selecteEmotion:emotionView.emotion];
    } else { // 手没有松开
        // 显示表情弹出控件
        [self.popView showFromEmotionView:emotionView];
    }
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加新的表情
    int count = emotions.count;
    int currentEmotionViewCount = self.emotionViews.count;
    for (int i = 0; i < count; i++) {
        JHEmotionView *emotionView = nil;
        
        if (i >= currentEmotionViewCount) {// emotionView不够用
            emotionView = [[JHEmotionView alloc] init];
//            emotionView.backgroundColor = JHRandomColor;
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else {// emotionView够用
            emotionView = self.emotionViews[i];
        }
        
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
        
        // 隐藏多余的emotionView
        for (int i = count; i < currentEmotionViewCount; i++) {
            UIButton *emotionView = self.emotionViews[i];
            emotionView.hidden = YES;
        }
    }
    
}

/**
 *  监听表情的单击
 */
- (void)emotionClick:(JHEmotionView *)emotionView
{
    [self.popView showFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
        
        // 选中表情
        [self selecteEmotion:emotionView.emotion];
    });
    
}

/**
 *  选中表情
 */
- (void)selecteEmotion:(JHEmotion *)emotion
{
    if (emotion == nil) return;
    
#warning 注意：先添加使用的表情，再发通知，这样才能拿到最新的表情
    // 保存使用记录
    [JHEmotionTool addRecentEmotion:emotion];
    
    // 发出一个选中表情的通知，通知发微博控制器
    [[NSNotificationCenter defaultCenter] postNotificationName:JHEmotionDidSelectedNotification object:nil userInfo:@{JHSelectedEmotion : emotion}];
}

/**
 *  点击了删除按钮
 */
- (void)deleteClick
{
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:JHEmotionDidDeletedNotification object:nil userInfo:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    // 1.排列所有的表情
    // 每个表情button之前没有空隙连成一个整体
    int count = self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / JHEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / JHEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % JHEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / JHEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    // 2.删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
}


@end
