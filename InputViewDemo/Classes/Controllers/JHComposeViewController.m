//
//  JHComposeViewController.m
//  JHInputView
//
//  Created by piglikeyoung on 15/11/17.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

#import "JHComposeViewController.h"
#import "JHEmotionTextView.h"
#import "JHComposeToolbar.h"
#import "JHComposePhotosView.h"
#import "JHEmotionKeyboard.h"
#import "JHEmotion.h"
#import "UIView+Extension.h"
#import "JHMacro.h"

@interface JHComposeViewController () <JHComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate ,UIImagePickerControllerDelegate>

@property (nonatomic, weak) JHEmotionTextView *textView;
@property (nonatomic, weak) JHComposeToolbar *toolbar;
@property (nonatomic, weak) JHComposePhotosView *photosView;
@property (strong , nonatomic) JHEmotionKeyboard *kerboard;

/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;

@end

@implementation JHComposeViewController

#pragma mark - 初始化方法
- (JHEmotionKeyboard *)kerboard
{
    if (!_kerboard) {
        self.kerboard = [JHEmotionKeyboard keyboard];
        self.kerboard.width = JHScreenW;
        self.kerboard.height = 216;
    }
    
    return _kerboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setupNavBar];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加显示图片的相册控件
    [self setupPhotosView];
    
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:JHEmotionDidSelectedNotification object:nil];
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:JHEmotionDidDeletedNotification object:nil];
    
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}

// 添加显示图片的相册控件
- (void)setupPhotosView
{
    JHComposePhotosView *photoView = [[JHComposePhotosView alloc] init];
    photoView.width = self.textView.width;
    photoView.height = self.textView.height;
    photoView.y = 70;
    [self.textView addSubview:photoView];
    self.photosView = photoView;
}


// 添加工具条
- (void)setupToolbar
{
    // 1.创建
    JHComposeToolbar *toolbar = [[JHComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.delegate = self;
    self.toolbar = toolbar;
    
    // 2.显示
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
}

// 添加输入控件
- (void)setupTextView
{
    // 1.创建输入控件
    JHEmotionTextView *textView = [[JHEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textView.delegate = self;
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"分享新鲜事...";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 设置导航条内容
- (void)setupNavBar
{
    NSString *name = nil;
    if (name) {
        // 构建文字
        NSString *prefix = @"发微博";
        NSString *text = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[text rangeOfString:prefix]];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[text rangeOfString:name]];
        
        // 创建label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.attributedText = string;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    } else {
        self.title = @"发微博";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - 私有方法
/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
- (void)send
{
    // 1.发送微博
    if (self.photosView.images.count) {
        [self sendStatusWithImage];
    }else {
        [self sendStatusWithoutImage];
    }
    
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发表有图片的微博
 */
- (void)sendStatusWithImage
{
    
}

// 图文混排 ： 图片和文字混合在一起排列

/**
 *  发表没有图片的微博
 */
- (void)sendStatusWithoutImage
{
    
    
    
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 切换表情键盘的时候，toolbar位置不变
    if (self.isChangingKeyboard) return;
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}


/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        // 键盘的高度就是toolbar向上移动的高度
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
    
}


#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void) textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(JHComposeToolbar *)toolbar didClickedButton:(JHComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case JHComposeToolbarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case JHComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case JHComposeToolbarButtonTypeEmotion: // 表情
            [self openEmotion];
            break;
            
        default:
            break;
    }
    
}

/**
 *  打开照相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开表情
 */
- (void)openEmotion
{
    // 正在切换键盘，告诉toolbar不跟着键盘下落
    self.changingKeyboard = YES;
    
    // 判断是否是自定义键盘
    if (self.textView.inputView) {// 是自定义键盘，切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情图片
        self.toolbar.showEmotionButton = YES;
        
    } else { // 是系统自带的键盘，切换为自定义键盘
        // 如果临时更换了文本框的键盘，一定要重新打开键盘(关闭原来的键盘，打开新的)
        self.textView.inputView = self.kerboard;
        
        // 不显示表情图片
        self.toolbar.showEmotionButton = NO;
    }
    
    // 关闭键盘
    [self.textView resignFirstResponder];
    
    // 切换完成，告诉toolbar可以回落了
    self.changingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.textView becomeFirstResponder];
    });
}

/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    JHEmotion *emotion = note.userInfo[JHSelectedEmotion];
    
    // 1.拼接表情
    [self.textView appendEmotion:emotion];
    
    // 2.检测文字长度
    [self textViewDidChange:self.textView];
}

/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    // 往回删
    [self.textView deleteBackward];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.添加图片到相册中
    [self.photosView addImage:image];
}

@end
