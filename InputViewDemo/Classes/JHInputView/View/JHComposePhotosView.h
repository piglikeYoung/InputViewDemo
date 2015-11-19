//
//  JHComposePhotosView.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/4.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHComposePhotosView : UIView

/**
 *  添加一张图片到相册内部
 *
 *  @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image;

- (NSArray *)images;

@end
