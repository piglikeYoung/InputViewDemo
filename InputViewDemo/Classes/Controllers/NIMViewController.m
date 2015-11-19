//
//  NIMViewController.m
//  InputViewDemo
//
//  Created by piglikeyoung on 15/11/19.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

#import "NIMViewController.h"
#import "NIMInputView.h"
#import "NTESSessionConfig.h"
#import "UIView+NIM.h"
#import "NIMUIConfig.h"
#import "NIMInputProtocol.h"

@interface NIMViewController()<NIMInputActionDelegate>

// 输入框
@property (nonatomic,weak) NIMInputView *sessionInputView;

@end

@implementation NIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self makeUI];
}

- (void)makeUI {
    
    CGRect inputViewRect = CGRectMake(0, 0, self.view.nim_width, [NIMUIConfig topInputViewHeight]);
    
    // 创建输入框
    NIMInputView *sessionInputView = [[NIMInputView alloc] initWithFrame:inputViewRect];
    self.sessionInputView = sessionInputView;
    [self.sessionInputView setInputConfig:[[NTESSessionConfig alloc] init]];
    [self.sessionInputView setInputActionDelegate:self];
    [self.view addSubview:self.sessionInputView];
    
}

- (void)viewDidLayoutSubviews{
    // 设置输入框的位置
    self.sessionInputView.nim_bottom = self.view.nim_height;
}

#pragma mark - Touch Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_sessionInputView endEditing:YES];
}

@end
