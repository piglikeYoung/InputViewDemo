//
//  JHComposeToolbar.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JHComposeToolbarButtonTypeCamera, // 照相机
    JHComposeToolbarButtonTypePicture, // 相册
    JHComposeToolbarButtonTypeMention, // 提到@
    JHComposeToolbarButtonTypeTrend, // 话题
    JHComposeToolbarButtonTypeEmotion // 表情
} JHComposeToolbarButtonType;

@class JHComposeToolbar;

@protocol JHComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(JHComposeToolbar *)toolbar didClickedButton:(JHComposeToolbarButtonType)buttonType;

@end

@interface JHComposeToolbar : UIView


@property (nonatomic, weak) id<JHComposeToolbarDelegate> delegate;

/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;

@end
