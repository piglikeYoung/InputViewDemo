//
//  JHComposeToolbar.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHComposeToolbar.h"
#import "UIView+Extension.h"

@interface JHComposeToolbar()

@property (weak , nonatomic) UIButton *emotionButton;

@end

@implementation JHComposeToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        // 添加所有的子控件
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:JHComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:JHComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:JHComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:JHComposeToolbarButtonTypeTrend];
        self.emotionButton = [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:JHComposeToolbarButtonTypeEmotion];
    }
    return self;
}


- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton = showEmotionButton;
    if (showEmotionButton) { // 显示表情按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else { // 切换为键盘按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

/**
 *  添加一个按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(JHComposeToolbarButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
    
    return button;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickedButton:)]) {
        [self.delegate composeTool:self didClickedButton:button.tag];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.subviews.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    for (int i = 0; i< count; i++) {
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}

@end
