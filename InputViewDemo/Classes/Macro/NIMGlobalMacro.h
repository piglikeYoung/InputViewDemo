//
//  NIMGlobalMacro.h
//  NIMKit
//
//  Created by chris.
//  Copyright (c) 2015年 Netease. All rights reserved.
//


#define NIMKit_IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define NIMKit_UIScreenWidth   [UIScreen mainScreen].bounds.size.width
#define NIMKit_UIScreenHeight  [UIScreen mainScreen].bounds.size.height


#pragma mark - UIColor宏定义
#define NIMKit_UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define NIMKit_UIColorFromRGB(rgbValue) NIMKit_UIColorFromRGBA(rgbValue, 1.0)
