//
//  JHEmotionPopView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/10.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHEmotionPopView.h"
#import "JHEmotionView.h"
#import "UIView+Extension.h"

@interface JHEmotionPopView()

@property (weak, nonatomic) IBOutlet JHEmotionView *emotionView;


@end

@implementation JHEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JHEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromEmotionView:(JHEmotionView *)fromEmotionView
{
    // 1.显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    // 2.添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = fromEmotionView.centerX;// 表情按钮的X值
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    // 坐标系转换，原坐标系转为window的坐标系
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect
{
    // 显示提示框，占满整个xib
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}

@end
