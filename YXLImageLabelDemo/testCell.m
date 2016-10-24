//
//  testCell.m
//  YXLImageLabelDemo
//
//  Created by ZHY on 2016/10/24.
//  Copyright © 2016年 叶星龙. All rights reserved.
//

#import "testCell.h"
#import "YXLTagEditorImageView.h"

@interface testCell (){
    YXLTagEditorImageView *tagEditorImageView;
}

@end

@implementation testCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    tagEditorImageView =[[YXLTagEditorImageView alloc]initWithImage:[UIImage imageNamed:@"2011102267331457.jpg"]];
    tagEditorImageView.viewC=self.viewController;
    tagEditorImageView.userInteractionEnabled=YES;
    [self.contentView addSubview:tagEditorImageView];
    [tagEditorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [tagEditorImageView addTagViewText:@"哈哈哈哈" Location:CGPointMake(448.309179,296.296296) isPositiveAndNegative:YES];
    
    [tagEditorImageView addTagViewText:@"哈哈lalallallal" Location:CGPointMake(430.917874, 295.652174) isPositiveAndNegative:NO];
    
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString*)identifier
{
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //取消选中状态
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
- (UITableView *)tableView{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
@end
