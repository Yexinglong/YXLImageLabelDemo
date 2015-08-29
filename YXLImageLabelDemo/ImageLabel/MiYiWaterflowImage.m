//
//  MiYiWaterflowImage.m
//  MiYi
//
//  Created by 叶星龙 on 15/8/17.
//  Copyright (c) 2015年 北京美耶时尚信息科技有限公司. All rights reserved.
//

#import "MiYiWaterflowImage.h"

@implementation MiYiWaterflowImage

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =[super initWithCoder:aDecoder];
    if (self) {
        self.layer.masksToBounds=YES;
        _labelText =[[UILabel alloc]initWithFrame:(CGRect){8,0,self.bounds.size.width-8,self.bounds.size.height}];
        _labelText.font =Font(11);
        [self addSubview:_labelText];
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds=YES;
        _labelText =[[UILabel alloc]initWithFrame:(CGRect){8,0,self.bounds.size.width-8,self.bounds.size.height}];
        _labelText.font =Font(11);
        [self addSubview:_labelText];
    }
    return self;
}

@end
