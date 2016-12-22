//
//  QBNaviBarView.h
//  PRJ_CreditRecruit
//
//  Created by 任强宾 on 16/5/17.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBNaviBarView : UIView

@property (nonatomic, strong) UIView *statusBar;
@property (nonatomic, strong) UIView *naviBar;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

//初始化方法
- (instancetype)initWithStatusBarColor:(UIColor *)statusBarColor
                          naviBarColor:(UIColor *)naviBarColor;

@end
