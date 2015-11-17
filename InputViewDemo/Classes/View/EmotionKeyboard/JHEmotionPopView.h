//
//  JHEmotionPopView.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/10.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHEmotionView;

@interface JHEmotionPopView : UIView

/**
 *  加载弹出控件xib
 */
+ (instancetype)popView;

/**
 *  显示表情弹出控件
 *
 *  @param emotionView 从哪个表情上面弹出
 */
- (void)showFromEmotionView:(JHEmotionView *)fromEmotionView;
- (void)dismiss;
@end
