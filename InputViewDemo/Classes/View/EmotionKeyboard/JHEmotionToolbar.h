//
//  JHEmotionToolbar.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/9.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHEmotionToolbar;

typedef enum {
    JHEmotionTypeRecent, // 最近
    JHEmotionTypeDefault, // 默认
    JHEmotionTypeEmoji, // Emoji
    JHEmotionTypeLxh // 浪小花
} JHEmotionType;

@protocol JHEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(JHEmotionToolbar *)toolbar didSelectedButton:(JHEmotionType)emotionType;

@end

@interface JHEmotionToolbar : UIView

@property (weak , nonatomic) id<JHEmotionToolbarDelegate> delegate;

@end
