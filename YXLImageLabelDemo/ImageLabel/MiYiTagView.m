//
//  MiYiTagView.m
//  MiYi
//
//  Created by 叶星龙 on 15/8/26.
//  Copyright (c) 2015年 北京美耶时尚信息科技有限公司. All rights reserved.
//

#import "MiYiTagView.h"
#import "NSTimer+Addition.h"
#import "MiYiWaterflowImage.h"

@interface MiYiTagView ()



@property (nonatomic , strong) NSTimer *animationTimer;

@property (nonatomic , assign) NSTimeInterval animation;

@property (nonatomic ,weak) UIView *spreadView;

@property (nonatomic ,weak)  UIView *tagTapView;


@end
@implementation MiYiTagView


-(instancetype)init
{
    self =[super init];
    if (self) {
        self.animationTimer =[NSTimer scheduledTimerWithTimeInterval:3
                                                              target:self
                                                            selector:@selector(animationTimerDidFired)
                                                            userInfo:nil
                                                             repeats:YES];
        
        [self initUI];
    }
    
    return self;
}

-(void)initUI
{
    UIImage *tagTapIcon =[UIImage imageNamed:@"TagTapIcon"];
    UIImage *textTag =[UIImage imageNamed:@"textTag"];
    self.frame =(CGRect){0,0,tagTapIcon.size.width +textTag.size.width+3,textTag.size.height};
    UIView *spreadView =[[UIView alloc]initWithFrame:(CGRect){{0,textTag.size.height/2-tagTapIcon.size.height/2},tagTapIcon.size}];
    
    spreadView.backgroundColor=UIColorRGBA(0, 0, 0, 0.7);
    spreadView.layer.cornerRadius=tagTapIcon.size.width/2;
    spreadView.userInteractionEnabled=NO;
    _spreadView=spreadView;
    
    UIView *tagTapView =[[UIView alloc]initWithFrame:(CGRect){0,0,tagTapIcon.size.width+1,tagTapIcon.size.height+1}];
    tagTapView.backgroundColor=HEX_COLOR_THEME;
    tagTapView.center =spreadView.center;
    tagTapView.layer.cornerRadius=(tagTapIcon.size.width+1)/2;
    tagTapView.userInteractionEnabled=NO;
    _tagTapView=tagTapView;
    
    MiYiWaterflowImage *waterflowImage =[[MiYiWaterflowImage alloc]initWithFrame:(CGRect){{CGRectGetMaxX(tagTapView.frame)+3,0},textTag.size}];
    waterflowImage.labelText.text=@"";
    waterflowImage.labelText.textColor=[UIColor whiteColor];
    waterflowImage.alpha=0;
    waterflowImage.userInteractionEnabled=YES;
    waterflowImage.image=textTag;;
    _waterflowImage=waterflowImage;
    
    
    [self addSubview:spreadView];
    [self addSubview:tagTapView];
    [self addSubview:waterflowImage];
    
    
    
    
    [self.animationTimer resumeTimer];
}

-(void)setIsTagImageShow:(BOOL)isTagImageShow
{
    _isTagImageShow=isTagImageShow;
    if (!isTagImageShow) {
        _waterflowImage.alpha=1;
    }
}

-(void)animationTimerDidFired
{
    [UIView animateWithDuration:1 animations:^{
        _tagTapView.transform = CGAffineTransformMakeScale(1.3,1.3);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            _tagTapView.transform = CGAffineTransformIdentity;

        }completion:^(BOOL finished) {
            _spreadView.alpha=1;
            [UIView animateWithDuration:1 animations:^{
                _spreadView.alpha=0;
                _spreadView.transform = CGAffineTransformMakeScale(5,5);
            }completion:^(BOOL finished) {
                _spreadView.transform = CGAffineTransformIdentity;
                
            }];
        }];
        
    }];
    
    
    
}

-(void)setOverturn:(BOOL)overturn
{
    
    _overturn=overturn;
    UIImage *tagTapIcon =[UIImage imageNamed:@"TagTapIcon"];

    if (overturn) {
        _spreadView.center =CGPointMake(self.frame.size.width-tagTapIcon.size.width/2, _spreadView.center.y);
        _tagTapView.center=_spreadView.center;
        _waterflowImage.frame=(CGRect){{0,CGOriginY(_waterflowImage.frame)},_waterflowImage.frame.size};
        UIImage *image =[UIImage imageNamed:@"textTagAnti"];
        _waterflowImage.image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 10)];
        _waterflowImage.labelText.frame =(CGRect){0,0,CGWidth(_waterflowImage.labelText.frame),CGHeight(_waterflowImage.labelText.frame)};
        _waterflowImage.labelText.textAlignment=NSTextAlignmentRight;
        NSLog(@"YES %@",NSStringFromCGRect(_spreadView.frame));

  
    }else
    {
        _spreadView.center=CGPointMake(tagTapIcon.size.width/2, _spreadView.center.y);
        _tagTapView.center=_spreadView.center;
        _waterflowImage.frame=(CGRect){{tagTapIcon.size.width+3,CGOriginY(_waterflowImage.frame)},_waterflowImage.frame.size};
        UIImage *image =[UIImage imageNamed:@"textTag"];
        _waterflowImage.image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(3, 10, 3, 3)];
        _waterflowImage.labelText.frame =(CGRect){8,0,CGWidth(_waterflowImage.labelText.frame),CGHeight(_waterflowImage.labelText.frame)};
        _waterflowImage.labelText.textAlignment=NSTextAlignmentLeft;
        NSLog(@"NO %@",NSStringFromCGRect(_spreadView.frame));
    }
    
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
};

@end
