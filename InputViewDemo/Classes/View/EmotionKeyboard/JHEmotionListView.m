//
//  JHEmotionListView.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/9.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//


#import "JHEmotionListView.h"
#import "JHEmotionGridView.h"
#import "JHMacro.h"
#import "UIView+Extension.h"

@interface JHEmotionListView() <UIScrollViewDelegate>
/** 显示所有表情的UIScrollView */
@property (weak , nonatomic) UIScrollView *scrollView;
/** 显示页码的UIPageControl */
@property (weak , nonatomic) UIPageControl *pageControl;

@end

@implementation JHEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        // 1.显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}


- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 设置总页数
    int totalPages = (emotions.count + JHEmotionMaxCountPerPage - 1) / JHEmotionMaxCountPerPage;
    int currentGridViewCount = self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    
    // 决定scrollView显示多少页表情
    for (int i= 0; i < totalPages; i++) {
        
        // 获得i位置对应的JHEmotionGridView
        JHEmotionGridView *gridView = nil;
        if (i >= currentGridViewCount) { // 说明JHEmotionGridView的个数不够
            gridView = [[JHEmotionGridView alloc] init];
            [self.scrollView addSubview:gridView];
        } else { // 说明JHEmotionGridView的个数足够，从self.scrollView.subviews中取出JHEmotionGridView
            gridView = self.scrollView.subviews[i];
        }
        
        // 给JHEmotionGridView设置表情数据
        int loc = i * JHEmotionMaxCountPerPage;
        int len = JHEmotionMaxCountPerPage;
        // 如果超过了总数，该页的显示表情数 = 表情总数 - 该页起始表情索引
        if (loc + len > emotions.count) { // 对越界进行判断处理
            len = emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        gridView.hidden = NO;
    }
    
    // 隐藏后面的不需要用到的gridView
    for (int i = totalPages; i < currentGridViewCount; i++) {
        JHEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
    
    // 表情滚到最前面
    self.scrollView.contentOffset = CGPointZero;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.UIPageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.UIScrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    // 3.设置UIScrollView内部控件的尺寸
    int count = self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        JHEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridW;
        gridView.height = gridH;
        gridView.x = i * gridW;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 滑动显示的页码
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

@end
