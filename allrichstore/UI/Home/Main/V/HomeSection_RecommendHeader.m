//
//  HomeSection_RecommendHeader.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "HomeSection_RecommendHeader.h"

@interface HomeSection_RecommendHeader ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UIView *rightLineView;

@end

@implementation HomeSection_RecommendHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
        
        self.textLabel = [UILabel new];
        _textLabel.textColor = kGrayColor_D;
        _textLabel.font = AdaptedFont(15);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.text = String(@"为您推荐的宝贝");
        
        
        self.leftLineView = [UIView new];
        _leftLineView.backgroundColor = [UIColor colorWithWhite:0.86 alpha:1.0];
        ;
        
        self.rightLineView = [UIView new];
        _rightLineView.backgroundColor = [UIColor colorWithWhite:0.86 alpha:1.0];;
        
        [self addSubview:_textLabel];
        [self addSubview:_leftLineView];
        [self addSubview:_rightLineView];
        [self layoutSubview];
    }
    return self;
}

- (void)layoutSubview
{
    [_textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.width.offset([_textLabel getWidth] + Adapted(16));
        make.top.offset(0);
        make.bottom.offset(0);
        
    }];
    
    [_leftLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.right.equalTo(_textLabel.mas_left).offset(0);
        make.centerY.offset(0);
        make.height.offset(0.7);
        
    }];
    
    [_rightLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(0);
        make.left.equalTo(_textLabel.mas_right).offset(0);
        make.centerY.offset(0);
        make.height.offset(0.7);
        
    }];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _textLabel.text = title;
    [self layoutSubview];
}

@end
