//
//  JHEmotionAttachment.m
//  黑马微博
//
//  Created by piglikeyoung on 15/4/11.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHEmotionAttachment.h"
#import "JHEmotion.h"

@implementation JHEmotionAttachment

- (void)setEmotion:(JHEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
}

@end
