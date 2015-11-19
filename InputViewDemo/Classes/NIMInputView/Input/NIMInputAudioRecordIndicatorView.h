//
//  NIMInputAudioRecordIndicatorView.h
//  NIMInput
//
//  Created by piglikeyoung on 15/11/19.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

#import "NIMInputView.h"

@interface NIMInputAudioRecordIndicatorView : UIView

@property (nonatomic, assign) NIMAudioRecordPhase phase;

@property (nonatomic, assign) NSTimeInterval recordTime;

@end
