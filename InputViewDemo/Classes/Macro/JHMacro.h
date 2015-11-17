//
//  JHMacro.h
//  JHInputView
//
//  Created by piglikeyoung on 15/11/17.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

// 通知
// 表情选中的通知
#define JHEmotionDidSelectedNotification @"JHEmotionDidSelectedNotification"
// 点击删除按钮的通知
#define JHEmotionDidDeletedNotification @"JHEmotionDidDeletedNotification"
// 通知里面取出表情用的key
#define JHSelectedEmotion @"JHSelectedEmotion"

/** 表情相关 */
// 表情的最大行数
#define JHEmotionMaxRows 3
// 表情的最大列数
#define JHEmotionMaxCols 7
// 每页最多显示多少个表情
#define JHEmotionMaxCountPerPage (JHEmotionMaxRows * JHEmotionMaxCols - 1)

// 屏幕尺寸
#define JHScreenW [UIScreen mainScreen].bounds.size.width
