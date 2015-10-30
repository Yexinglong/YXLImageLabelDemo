//
//  pch.h
//  YXLImageLabelDemo
//
//  Created by 叶星龙 on 15/8/29.
//  Copyright (c) 2015年 叶星龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Masonry.h"

@interface pch : NSObject
// 细字体
#define Font(F)                 [UIFont systemFontOfSize:(F)]
// 粗字体
#define boldFont(F)             [UIFont boldSystemFontOfSize:(F)]
// 标准的RGBA设置
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEX_COLOR_THEME             UIColorRGBA(255,96,184,1)//主题颜色

#define HEX_COLOR_VIEW_BACKGROUND   UIColorRGBA(238, 238, 238, 1) //视图底色

#ifndef CGWidth
#define CGWidth(rect)                   rect.size.width
#endif

#ifndef CGHeight
#define CGHeight(rect)                  rect.size.height
#endif

#ifndef CGOriginX
#define CGOriginX(rect)                 rect.origin.x
#endif

#ifndef CGOriginY
#define CGOriginY(rect)                 rect.origin.y
#endif

// 屏幕大小
#define kScreenBounds [[UIScreen                          mainScreen]bounds]
#define kWindowWidth  ([[UIScreen mainScreen]             bounds].size.width)
#define kWindowHeight ([[UIScreen mainScreen]             bounds].size.height)



@end
