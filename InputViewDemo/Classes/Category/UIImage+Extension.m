//
//  UIImage+Extension.m
//  黑马微博
//
//  Created by piglikeyoung on 15/3/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


+(UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
