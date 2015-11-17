//
//  JHEmotionTextView.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHTextView.h"
@class JHEmotion;

@interface JHEmotionTextView : JHTextView
/**
 *  拼接表情到attributedText
 */
- (void)appendEmotion:(JHEmotion *)emotion;

/**
 *  富文本中真正内容，表情图片都转为字符串
 */
- (NSString *)realText;

@end
