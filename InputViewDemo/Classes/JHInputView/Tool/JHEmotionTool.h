//
//  JHEmotionTool.h
//  JHInputView
//
//  Created by piglikeyoung on 15/11/17.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  管理表情数据：加载表情数据、存储表情使用记录

#import <Foundation/Foundation.h>

@class JHEmotion;

@interface JHEmotionTool : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(JHEmotion *)emotion;

/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (JHEmotion *)emotionWithDesc:(NSString *)desc;
@end
