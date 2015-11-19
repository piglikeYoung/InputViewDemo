//
//  NIMInputEmoticonContainerView.h
//  NIMInput
//
//  Created by piglikeyoung on 15/11/18.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

#import "NIMPageView.h"

@class NIMInputEmoticonCatalog;
@class NIMInputEmoticonTabView;

@protocol NIMInputEmoticonProtocol <NSObject>

- (void)didPressSend:(id)sender;

- (void)selectedEmoticon:(NSString*)emoticonID catalog:(NSString*)emotCatalogID description:(NSString *)description;

@end


@interface NIMInputEmoticonContainerView : UIView<NIMPageViewDataSource,NIMPageViewDelegate>

@property (nonatomic, strong)  NIMPageView *emoticonPageView;
@property (nonatomic, strong)  UIPageControl  *emotPageController;
@property (nonatomic, strong)  NIMInputEmoticonCatalog    *currentCatalogData;
@property (nonatomic, readonly)NIMInputEmoticonCatalog    *nextCatalogData;
@property (nonatomic, readonly)NSArray            *allEmoticons;
@property (nonatomic, strong)  NIMInputEmoticonTabView   *tabView;
@property (nonatomic, weak)    id<NIMInputEmoticonProtocol>  delegate;

@end
