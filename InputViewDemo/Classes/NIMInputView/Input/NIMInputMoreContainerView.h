//
//  NIMInputMoreContainerView.h
//  NIMInput
//
//  Created by piglikeyoung on 15/11/18.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMSessionConfig.h"
#import "NIMInputProtocol.h"

@interface NIMInputMoreContainerView : UIView

@property (nonatomic,weak)  id<NIMSessionConfig> config;
@property (nonatomic,weak)  id<NIMInputActionDelegate> actionDelegate;

@end
