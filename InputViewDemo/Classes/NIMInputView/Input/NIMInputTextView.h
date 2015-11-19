//
//  NIMInputTextView.h
//  NIMInput
//
//  Created by piglikeyoung on 15/11/18.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NIMInputTextView : UITextView

@property (nonatomic, strong) NSString *placeHolder;

- (void)setCustomUI;

@end
