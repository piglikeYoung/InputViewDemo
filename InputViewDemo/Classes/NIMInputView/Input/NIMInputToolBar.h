//
//  NIMInputToolBar.h
//  NIMInput
//
//  Created by piglikeyoung on 15/11/18.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIMInputTextView;

@interface NIMInputToolBar : UIView

@property (nonatomic,strong) UIButton    *voiceBtn;

@property (nonatomic,strong) UIButton    *emoticonBtn;

@property (nonatomic,strong) UIButton    *moreMediaBtn;

@property (nonatomic,strong) UIButton    *recordButton;

@property (nonatomic,strong) UIImageView *inputTextBkgImage;

@property (nonatomic,strong) NIMInputTextView *inputTextView;

@end
