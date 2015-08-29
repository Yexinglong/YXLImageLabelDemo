//
//  MiYiTagsVC.m
//  MiYi
//
//  Created by 叶星龙 on 15/8/21.
//  Copyright (c) 2015年 北京美耶时尚信息科技有限公司. All rights reserved.
//

#import "MiYiTagsVC.h"
#import "MiYiTagView.h"
#import "MiYiView.h"
#import "MiYiTagSearchBarVC.h"
#import <Foundation/Foundation.h>

@interface MiYiTagsVC ()<UIGestureRecognizerDelegate>

@property (nonatomic ,strong) UIImageView *imageTag;


@property (nonatomic ,assign) CGFloat imageScale;

@property (nonatomic ,assign) CGPoint firstClick;

@property (nonatomic ,strong) NSMutableArray *tagArray;


@property (nonatomic ,weak) UIView  *coverView;

@property (nonatomic ,weak) UIButton * brandBtn;

@property (nonatomic ,weak) UIButton * featureBtn;

@property (nonatomic ,weak) MiYiTagView *tagView;


@end

@implementation MiYiTagsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view .backgroundColor =HEX_COLOR_VIEW_BACKGROUND;
    
    _image =[UIImage imageNamed:@"2011102267331457.jpg"];
    
    UIImageView *imageTag =[[UIImageView alloc]initWithImage:_image];
    imageTag.center = CGPointMake(kWindowWidth/2, (kWindowHeight-64)/2);
    imageTag.userInteractionEnabled=YES;
    [self.view addSubview:imageTag];
    _imageTag=imageTag;
    
    UITapGestureRecognizer* imageTagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTagTapClick:)];
    imageTagTap.numberOfTapsRequired=1;
    imageTagTap.numberOfTouchesRequired=1;
    imageTagTap.delegate = self;
    [imageTag addGestureRecognizer:imageTagTap];
    
    
    UIBarButtonItem *item =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(navItemClick)];
    self.navigationItem.rightBarButtonItem=item;
    
    
    self.tagArray =[NSMutableArray array];
    
    
    [self imageTagFrame];
    
    
    
    [self initTagUI];
    
}
/**
 *  初始化mbp界面
 */
-(void)initTagUI
{
    UIView *coverView =[[UIView alloc]initWithFrame:self.view.bounds];
    coverView.alpha=0;
    _coverView=coverView;
    
    MiYiView *mbpView =[[MiYiView alloc]initWithFrame:self.view.bounds];
    [mbpView addTarget:self action:@selector(mbpViewClick) forControlEvents:MiYiViewControlEventTap ];
    
    
    CGFloat WH =100;
    
    UIButton * featureBtn =[[UIButton alloc]initWithFrame:(CGRect){0,0,WH,WH}];
    featureBtn.center = CGPointMake(kWindowWidth/2-WH/1.3, kWindowHeight/2);
    featureBtn.backgroundColor=UIColorRGBA(0, 0, 0, 0.6);
    [featureBtn addTarget:self action:@selector(featureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [featureBtn setTitle:@"特点" forState:UIControlStateNormal];
    featureBtn.layer.cornerRadius=WH/2;
    _featureBtn =featureBtn;
    
    UIButton * brandBtn =[[UIButton alloc]initWithFrame:(CGRect){0,0,WH,WH}];
    brandBtn.center = CGPointMake(kWindowWidth/2+WH/1.3, kWindowHeight/2);
    brandBtn.backgroundColor=UIColorRGBA(0, 0, 0, 0.6);
    [brandBtn addTarget:self action:@selector(brandBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [brandBtn setTitle:@"品牌" forState:UIControlStateNormal];
    brandBtn.layer.cornerRadius=WH/2;
    _brandBtn =brandBtn;
    
    [self.view addSubview:coverView];
    [coverView addSubview:mbpView];
    [coverView addSubview:featureBtn];
    [coverView addSubview:brandBtn];
    NSLog(@"%@",NSStringFromCGRect(_brandBtn.frame));
    
    //    [self initTagUIAnimate:];
    
    
}
/**
 *  mbp界面的动画
 */
-(void)initTagUIAnimate:(BOOL)animate
{
    
    if (animate) {
        [UIView animateWithDuration:0.1 animations:^{
            _coverView.alpha=1;
            _featureBtn.transform=CGAffineTransformMakeScale(1.2, 1.2);
            _brandBtn.transform=CGAffineTransformMakeScale(1.2,1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
                _featureBtn.transform=CGAffineTransformIdentity;
                _brandBtn.transform=CGAffineTransformIdentity;
            }completion:^(BOOL finished) {
                
            }];
        }];
        
    }else
    {
        [UIView animateWithDuration:0.1 animations:^{
            _coverView.alpha=0;
            
        }completion:^(BOOL finished) {
            if (self.tagArray.count !=0) {
                MiYiTagView *tag =[self.tagArray lastObject];
                if (tag.isTagImageShow) {
                    [tag removeFromSuperview];
                    [self.tagArray removeLastObject];
                }
            }
        }];
        
    }
    
}
/**
 *  点击mbp上面其他位子消失
 */
-(void)mbpViewClick
{
    [self initTagUIAnimate:NO];
}

-(void)featureBtnClick
{
    MiYiTagSearchBarVC *vc =[[MiYiTagSearchBarVC alloc]init];
    vc.block=^(NSString *text)
    {
        [self pop:text tagView:[self.tagArray lastObject]];
        MiYiTagView *tagView =(MiYiTagView *)[self.tagArray lastObject];
        [self tagViewPan:tagView point:tagView.center];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)brandBtnClick
{
    MiYiTagSearchBarVC *vc =[[MiYiTagSearchBarVC alloc]init];
    vc.block=^(NSString *text)
    {
        [self pop:text tagView:[self.tagArray lastObject]];
        MiYiTagView *tagView =(MiYiTagView *)[self.tagArray lastObject];
        [self tagViewPan:tagView point:tagView.center];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pop:(NSString *)text tagView:(MiYiTagView *)tageView
{
    MiYiTagView *tag =tageView;
    tag.isTagImageShow=NO;
    CGSize size =[text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font(11),NSFontAttributeName, nil]];
    UIImage *image =[UIImage imageNamed:@"TagTapIcon"];
    UIImage *imageTag =[UIImage imageNamed:@"textTag"];
    if (size.width < CGWidth(imageTag)-8) {
        tag.frame=(CGRect){tag.frame.origin.x,tag.frame.origin.y,CGWidth(image)+3+ CGWidth(imageTag),tag.frame.size.height};
        tag.waterflowImage.frame =(CGRect){tag.waterflowImage.frame.origin.x,tag.waterflowImage.frame.origin.y,CGWidth(imageTag),tag.waterflowImage.frame.size.height};
        tag.waterflowImage.labelText.frame =(CGRect){tag.waterflowImage.labelText
            .frame.origin.x,tag.waterflowImage.labelText
            .frame.origin.y,CGWidth(imageTag)-8,tag.waterflowImage.labelText.frame.size.height};
        tag.waterflowImage.image =[tag.waterflowImage.image resizableImageWithCapInsets:UIEdgeInsetsMake(3, 10, 3, 3)];
        tag.waterflowImage.labelText.textAlignment=NSTextAlignmentCenter;
    }else
    {
    CGFloat width = (size.width - ((CGWidth(tag.frame)-image.size.width)-8-3));
    tag.frame=(CGRect){tag.frame.origin.x,tag.frame.origin.y,tag.frame.size.width+width,tag.frame.size.height};
    tag.waterflowImage.frame =(CGRect){tag.waterflowImage.frame.origin.x,tag.waterflowImage.frame.origin.y,tag.waterflowImage.frame.size.width+width,tag.waterflowImage.frame.size.height};
    tag.waterflowImage.labelText.frame =(CGRect){tag.waterflowImage.labelText
        .frame.origin.x,tag.waterflowImage.labelText
        .frame.origin.y,tag.waterflowImage.labelText
        .frame.size.width+width,tag.waterflowImage.labelText.frame.size.height};
    tag.waterflowImage.image =[tag.waterflowImage.image resizableImageWithCapInsets:UIEdgeInsetsMake(3, 10, 3, 3)];
        tag.waterflowImage.labelText.textAlignment=NSTextAlignmentRight;
    }
    tag.waterflowImage.labelText.text =text;
    [self initTagUIAnimate:NO];
}
/**
 *  点击图片的位子创建一个标签
 */
-(void)imageTagTapClick:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view];
    
    MiYiTagView *tagView =[self addtagViewimage:point];
    [_imageTag addSubview:tagView];
    [self.tagArray addObject:tagView];
    _tagView=tagView;
    [self initTagUIAnimate:YES];
}
/**
 *  初始化一个标签
 *
 *  @param point 传入这个标签的位子
 *
 *  @return 返回这个标签
 */
-(MiYiTagView*)addtagViewimage:(CGPoint)point
{
    if (self.tagArray.count !=0) {
        MiYiTagView *tag =[self.tagArray lastObject];
        if (tag.isTagImageShow) {
            [tag removeFromSuperview];
            [self.tagArray removeLastObject];
        }
    }
    
    MiYiTagView *tagView =[[MiYiTagView alloc]init];
    _firstClick =CGPointMake(point.x +tagView.frame.size.width/2, point.y);
    tagView.center=_firstClick;
    tagView.isTagImageShow=YES;
    UIPanGestureRecognizer *tagViewPan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(tagViewPanClick:)];
    tagViewPan.minimumNumberOfTouches=1;
    tagViewPan.maximumNumberOfTouches=1;
    tagViewPan.delegate=self;
    [tagView addGestureRecognizer:tagViewPan];
    UITapGestureRecognizer* tagViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagViewTapClick:)];
    tagViewTap.numberOfTapsRequired=1;
    tagViewTap.numberOfTouchesRequired=1;
    tagViewTap.delegate = self;
    [tagView addGestureRecognizer:tagViewTap];
    UILongPressGestureRecognizer *tagViewLongPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tagViewLongPressClick:)];
    tagViewLongPress.minimumPressDuration=0.5;
    [tagView addGestureRecognizer:tagViewLongPress];
    tagViewLongPress.delegate=self;
    
    return tagView;

}
/**
 *  标签pan手势
 */
-(void)tagViewPanClick:(UIPanGestureRecognizer *)sender
{
    _tagView =(MiYiTagView *)sender.view;

    CGPoint point = [sender locationInView:_imageTag];
    
    [self tagViewPan:_tagView point:point];

   
}
/**
 *  标签pan手势 做了移动时候禁止移动到超出图片界边
 */
-(void)tagViewPan:(MiYiTagView *)sender point:(CGPoint)point
{
    if (CGRectGetMaxX(sender.frame)  >= CGWidth(_imageTag.frame) ) {
        
        if ((point.x+CGWidth(sender.frame)/2) < CGWidth(_imageTag.frame) && (point.y-CGHeight(sender.frame)/2) >0 && (point.y+CGHeight(sender.frame)/2) < CGHeight(_imageTag.frame)) {
            
            sender.center =CGPointMake(point.x , point.y);
            
        }else if( (point.y-CGHeight(sender.frame)/2) >0 && (point.y+CGHeight(sender.frame)/2) < CGHeight(_imageTag.frame))
        {
            sender.center =CGPointMake((CGWidth(_imageTag.frame)-CGWidth(sender.frame)/2 ), point.y);
        }else
        {
            if (CGRectGetMaxY(sender.frame) >= CGHeight(_imageTag.frame) ) {
                
                sender.center =CGPointMake((CGWidth(_imageTag.frame)-CGWidth(sender.frame)/2 ), (CGHeight(_imageTag.frame)-CGHeight(sender.frame)/2 ));
                
            }else if (CGOriginY(sender.frame)  <= 0)
            {
                
                sender.center =CGPointMake((CGWidth(_imageTag.frame)-CGWidth(sender.frame)/2 ), CGHeight(sender.frame)/2);
            }else
            {
                sender.center =CGPointMake((CGWidth(_imageTag.frame)-CGWidth(sender.frame)/2 ), point.y);
            }
        }
        return;
    }else if (CGOriginX(sender.frame)  <= 0)
    {
        
        if ((point.x-CGWidth(sender.frame)/2) >0 && (point.y-CGHeight(sender.frame)/2) >0 && (point.y+CGHeight(sender.frame)/2) < CGHeight(_imageTag.frame)) {
            
            sender.center =CGPointMake(point.x , point.y);
        }else if( (point.y-CGHeight(sender.frame)/2) >0 && (point.y+CGHeight(sender.frame)/2) < CGHeight(_imageTag.frame))
        {
            sender.center =CGPointMake((CGWidth(sender.frame)/2 ), point.y);
        }else
        {
            if (CGRectGetMaxY(sender.frame) >= CGHeight(_imageTag.frame) ) {
                sender.center =CGPointMake((CGWidth(sender.frame)/2 ), (CGHeight(_imageTag.frame)-CGHeight(sender.frame)/2 ));
                
            }else if (CGOriginY(sender.frame)  <= 0)
            {
                sender.center =CGPointMake((CGWidth(sender.frame)/2 ), CGHeight(sender.frame)/2);
            }else
            {
                sender.center =CGPointMake((CGWidth(sender.frame)/2 ), point.y);
            }
        }
        return;
    }else if (CGRectGetMaxY(sender.frame) >= CGHeight(_imageTag.frame))
    {
        if ((point.y+CGHeight(sender.frame)/2) < CGHeight(_imageTag.frame) && (point.x-CGWidth(sender.frame)/2) >0 && (point.x+CGWidth(sender.frame)/2) < CGWidth(_imageTag.frame)) {
            sender.center =CGPointMake(point.x , point.y);
        }else if((point.x-CGWidth(sender.frame)/2) >0 &&(point.x+CGWidth(sender.frame)/2) < CGWidth(_imageTag.frame))
        {
            sender.center =CGPointMake(point.x , (CGHeight(_imageTag.frame)-CGHeight(sender.frame)/2 ));
        }else
        {
            if (CGRectGetMaxX(sender.frame)  >= CGWidth(_imageTag.frame) ) {
                
                sender.center =CGPointMake((CGWidth(_imageTag.frame)-CGWidth(sender.frame)/2 ),  (CGHeight(_imageTag.frame)-CGHeight(sender.frame)/2 ));
                
            }else if(CGOriginX(sender.frame)  <= 0)
            {
                sender.center =CGPointMake((CGWidth(sender.frame)/2 ), (CGHeight(_imageTag.frame)-CGHeight(sender.frame)/2));
            }else
            {
                sender.center =CGPointMake(point.x , (CGHeight(_imageTag.frame)-CGHeight(sender.frame)/2 ));
            }
        }
        return;
        
    }else if (CGOriginY(sender.frame)  <= 0)
    {
        if ((point.y-CGHeight(sender.frame)/2) >0 && (point.x-CGWidth(sender.frame)/2) >0 && (point.x+CGWidth(sender.frame)/2) < CGWidth(_imageTag.frame)) {
            
            sender.center =CGPointMake(point.x , point.y);
            
        }else if((point.x-CGWidth(sender.frame)/2) >0 &&(point.x+CGWidth(sender.frame)/2) < CGWidth(_imageTag.frame))
        {
            sender.center =CGPointMake(point.x , CGHeight(sender.frame)/2 );
        }else
        {
            if (CGRectGetMaxX(sender.frame)  >= CGWidth(_imageTag.frame) ) {
                sender.center =CGPointMake((CGWidth(_imageTag.frame)-CGWidth(sender.frame)/2 ), CGHeight(sender.frame)/2 );
                
            }else if(CGOriginX(sender.frame)  <= 0)
            {
                sender.center =CGPointMake((CGWidth(sender.frame)/2 ),CGHeight(sender.frame)/2);
            }else
            {
                sender.center =CGPointMake(point.x , CGHeight(sender.frame)/2 );
                
            }
        }
        return;
    }else
        
        sender.center =CGPointMake(point.x , point.y);
}
/**
 *  点击标签进行翻转 当位子不够的时候就不让翻转
 */
-(void)tagViewTapClick:(UITapGestureRecognizer *)sender
{
    _tagView =(MiYiTagView *)sender.view;
    if(_tagView.overturn)
    {
        if (CGOriginX(sender.view.frame)+sender.view.frame.size.width>= CGWidth(_imageTag.frame)) {
            return;
        }
        sender.view.frame =(CGRect){{CGOriginX(sender.view.frame)+sender.view.frame.size.width ,CGOriginY(sender.view.frame)},sender.view.frame.size};
        _tagView.overturn=NO;
    }else
    {
        if (CGOriginX(sender.view.frame)-sender.view.frame.size.width<= 0) {
            return;
        }
        sender.view.frame =(CGRect){{CGOriginX(sender.view.frame)-sender.view.frame.size.width ,CGOriginY(sender.view.frame)},sender.view.frame.size};
        _tagView.overturn=YES;
    }
}
/**
 *  标签长按手势 长按弹出menu    有编辑和删除
 */
-(void)tagViewLongPressClick:(UILongPressGestureRecognizer *)sender
{
    _tagView =(MiYiTagView *)sender.view;

    if (sender.state ==UIGestureRecognizerStateBegan) {
        [sender.view becomeFirstResponder];
        UIMenuController *popMenu = [UIMenuController sharedMenuController];
        
        UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"编辑" action:@selector(menuItem1Pressed)];
        UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(menuItem2Pressed)];
        
        NSArray *menuItems = [NSArray arrayWithObjects:item1,item2,nil];
        [popMenu setMenuItems:menuItems];
        [popMenu setArrowDirection:UIMenuControllerArrowDown];
        [popMenu setTargetRect:sender.view.frame inView:_imageTag];
        [popMenu setMenuVisible:YES animated:YES];
    }
    
}

//编辑
-(void)menuItem1Pressed
{
    MiYiTagSearchBarVC *vc =[[MiYiTagSearchBarVC alloc]init];
    vc.block=^(NSString *text)
    {
        [self pop:text tagView:_tagView];
        [self tagViewPan:_tagView point:_tagView.center];

    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
//删除
-(void)menuItem2Pressed
{
    for (MiYiTagView *tagView in self.tagArray) {
        if ([tagView isEqual: _tagView]) {
            NSLog(@"%@   %@",tagView,_tagView);
            [self.tagArray removeObject:tagView];
            [_tagView removeFromSuperview];
            break;
        }
    }
}
/**
 *  确定并pop    返回这个图片所有的标签地址内容，是否翻转样式的数组   坐标为这个图片的真实坐标
 */
-(void)navItemClick
{
    
    NSMutableArray *array =[NSMutableArray array];
    for (MiYiTagView *tagView in self.tagArray) {
       
        
        NSString * style =@"0";
        NSString * position =[NSString stringWithFormat:@"%f,%f",CGOriginX(tagView.frame)/_imageScale,CGOriginY(tagView.frame)/_imageScale];
        if(tagView.overturn ==YES)
        {
            style =@"1";
            position =[NSString stringWithFormat:@"%f,%f",CGRectGetMaxX(tagView.frame)/_imageScale,CGOriginY(tagView.frame)/_imageScale];
        }
        
        NSString *string  =[NSString stringWithFormat:@"图片的上的真实坐标%@  \n  样式0为右边1为左边%@    \n  标签内容%@ \n",position ,style ,tagView.waterflowImage.labelText.text];
        [array addObject:string];
    }
    NSString *string1=@"";
    for (NSString *string in array) {
        string1 = [string1 stringByAppendingString:string];
    }
    _blockUI(string1);
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  计算出这个图片的在屏幕上显示不拉伸的最好的尺寸  并取出比例值
 */
-(void)imageTagFrame
{
    
    _imageTag.backgroundColor=[UIColor redColor];
    CGFloat imageScale;
    CGRect noScale = CGRectMake(0.0, 0.0, _image.size.width , _image.size.height );
    if (CGWidth(noScale) <= kWindowWidth && CGHeight(noScale) <= self.view.frame.size.height) {
        _imageScale = 1.0;
        _imageTag.frame= (CGRect){{kWindowWidth/2 -noScale.size.width/2,(kWindowHeight-64) /2 -noScale.size.height/2} ,noScale.size};
        return ;
    }
    
    CGRect scaled;
    
    imageScale= (kWindowHeight-64) / _image.size.height;
    scaled=CGRectMake(0.0, 0.0, _image.size.width * imageScale , _image.size.height * imageScale );
    if (CGWidth(scaled) <= kWindowWidth && CGHeight(scaled) <= (kWindowHeight-64)) {
        _imageScale = imageScale;
        _imageTag.frame= (CGRect){{kWindowWidth/2 -scaled.size.width/2,(self.view.frame.size.height-64) /2 -scaled.size.height/2} ,scaled.size};
        return ;
    }
    
    imageScale = kWindowWidth / _image.size.width;
    scaled = CGRectMake(0.0, 0.0, _image.size.width * imageScale, _image.size.height * imageScale);
    _imageScale = imageScale;
    _imageTag.frame=(CGRect){{kWindowWidth/2 -scaled.size.width/2,(kWindowHeight-64) /2 -scaled.size.height/2} ,scaled.size};
    // Do any additional setup after loading the view.
}



@end
