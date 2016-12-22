//
//  BlankPageView.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/4.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "BlankPageView.h"

#define ImageName_button_reload @"blankpage_button_reload"

#define ImageName_loadFail @"blankpage_image_loadFail"

#define ImageName_sleep @"blankpage_image_sleep"

@implementation BlankPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configWithType:(BlankPageType)blankPageType hasData:(BOOL)hasData noDataStr:(NSString *)noDataStr hasError:(BOOL)hasError errorStr:(NSString *)errorStr reloadButtonBlock:(void(^)(id sender))block {
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_monkeyView) {
        _monkeyView = [[UIImageView alloc] init];
        [self addSubview:_monkeyView];
        
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:17];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    //布局
    [_monkeyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_top).with.offset(100);
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_monkeyView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    _reloadButtonBlock = nil;
    
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_reloadButton setImage:[UIImage imageNamed:ImageName_button_reload] forState:UIControlStateNormal];
        _reloadButton.adjustsImageWhenHighlighted = YES;
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadButton];
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_tipLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(130, 40));
        }];
    }
    _reloadButton.hidden = NO;
    _reloadButtonBlock = block;
    
    if (hasError) {
        //        加载失败
        [_monkeyView setImage:[UIImage imageNamed:ImageName_loadFail]];
        _tipLabel.text = errorStr;
        
        if (blankPageType == BlankPageTypeMaterialScheduling) {
            _reloadButton.hidden = YES;
        }
        
    }else{
        //        空白数据
        if (_reloadButton) {
            _reloadButton.hidden = NO;
        }
        NSString *imageName, *tipStr;
        switch (blankPageType) {
            case BlankPageTypeProject:
            {
                imageName = ImageName_sleep;
                tipStr = noDataStr;
            }
                break;
            case BlankPageTypeNoButton:
            {
                imageName = ImageName_sleep;
                tipStr = noDataStr;
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
            default://其它页面（这里没有提到的页面，都属于其它）
            {
                imageName = ImageName_sleep;
                tipStr = noDataStr;
            }
                break;
        }
        [_monkeyView setImage:[UIImage imageNamed:imageName]];
        _tipLabel.text = tipStr;
    }
}

- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}

@end
