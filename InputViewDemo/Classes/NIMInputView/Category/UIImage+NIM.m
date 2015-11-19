//
//  UIImage+NIM.m
//  NIMKit
//
//  Created by chris.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "UIImage+NIM.h"
//#import "NIMInputEmoticonDefine.h"
//#import "NIMKit.h"

@implementation UIImage (NIM)

+ (UIImage *)nim_fetchImage:(NSString *)imageNameOrPath{
    UIImage *image = [UIImage imageNamed:imageNameOrPath];
    if (!image) {
        image = [UIImage imageWithContentsOfFile:imageNameOrPath];
    }
    return image;
}


+ (UIImage *)nim_imageInKit:(NSString *)imageName{
    NSString *name = [@"NIMKitResouce" stringByAppendingPathComponent:imageName];
    return [UIImage imageNamed:name];
}


@end
