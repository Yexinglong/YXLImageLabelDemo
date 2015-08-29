//
//  MiYiView.h
//  MiYi
//
//  Created by 叶星龙 on 15/8/10.
//  Copyright (c) 2015年 北京美耶时尚信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MiYiViewControlEvents) {
    MiYiViewControlEventTap,
    MiYiViewControlEventLongPressBegan,
    MiYiViewControlEventLongPressEnd,
};

@interface MiYiView : UIView


- (void)addTarget:(id)target action:(SEL)action forControlEvents:(MiYiViewControlEvents)controlEvents;
@end
