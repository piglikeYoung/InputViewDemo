//
//  UIImage+NIM.h
//  NIMKit
//
//  Created by chris.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NIM)

+ (UIImage *)nim_fetchImage:(NSString *)imageNameOrPath;

+ (UIImage *)nim_imageInKit:(NSString *)imageName;

@end
