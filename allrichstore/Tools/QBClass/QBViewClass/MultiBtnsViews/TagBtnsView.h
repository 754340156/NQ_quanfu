//
//  TagBtnsView.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagBtnsView;
//带一个NSString参数的block
typedef void(^TagBtnsViewConfigureBlock)(TagBtnsView *tagBtnsView);

//选中的blcok
typedef void(^TagBtnsViewSelectedBlock)(NSArray *stringArray, NSInteger index);

@interface TagBtnsView : UIView

//外界可以赋值  改变按钮的选中状态
@property (nonatomic, strong) NSArray *selectedStringArr;
@property (nonatomic, assign) NSInteger selectedIndex;

//上边距
@property (nonatomic, assign) CGFloat margin_top;
//下边距
@property (nonatomic, assign) CGFloat margin_bottom;
//左右边距
@property (nonatomic, assign) CGFloat margin_level;
//标题的高度
@property (nonatomic, assign) CGFloat titleLabelHeight;
//按钮的高度
@property (nonatomic, assign) CGFloat btnsHeight;
//标题和按钮的垂直距离
@property (nonatomic, assign) CGFloat space_vertical_title_Btn;
//按钮之间的垂直距离
@property (nonatomic, assign) CGFloat space_vertical_Btns;
//按钮之间的水平距离
@property (nonatomic, assign) CGFloat space_level_Btns;

//按钮的字体
@property (nonatomic, strong) UIFont *btnTitleFont;

//标题文字的默认颜色
@property (nonatomic, strong) UIColor *titleColor;

//按钮标题的默认颜色
@property (nonatomic, strong) UIColor *btnTitleNormalColor;
//按钮标题的选中颜色
@property (nonatomic, strong) UIColor *btnTitleSeletedColor;

//按钮的默认背景色
@property (nonatomic, strong) UIColor *btnNormalBgColor;
//按钮的选中背景色
@property (nonatomic, strong) UIColor *btnSelectedBgColor;

//按钮的默认边框颜色
@property (nonatomic, strong) UIColor *btnNormalBorderColor;
//按钮的选中边框颜色
@property (nonatomic, strong) UIColor *btnSelectedBorderColor;

//按钮默认图片
@property (nonatomic, strong) UIImage *btnNormalImage;
//按钮选中图片
@property (nonatomic, strong) UIImage *btnSelectedImage;

//按钮的圆角大小
@property (nonatomic, assign) CGFloat btnCornerRadius;
//按钮的边框的宽度
@property (nonatomic, assign) CGFloat btnBorderWidth;

@property (nonatomic, strong) UILabel *titleLabel;

//按钮的宽度是否相等
@property (nonatomic, assign) BOOL isSameWidth;

//刚好需要的高度
@property (nonatomic, assign) CGFloat justHeight;

//按钮的宽度由按钮标题的宽度决定
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title allArray:(NSArray *)allArray selectedArray:(NSArray *)selectedArray isMuti:(BOOL)isMuti configureBlcok:(TagBtnsViewConfigureBlock)configureBlcok selectedBlock:(TagBtnsViewSelectedBlock)block;

- (instancetype)initWithFrame:(CGRect)frame btnLayoutStyle:(QButtonLayoutStyle)btnLayoutStyle title:(NSString *)title allArray:(NSArray *)allArray selectedArray:(NSArray *)selectedArray btnCountALine:(NSUInteger)btnCountALine normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage titleAndImageSpace:(CGFloat)space isMuti:(BOOL)isMuti configureBlcok:(TagBtnsViewConfigureBlock)configureBlcok selectedBlock:(TagBtnsViewSelectedBlock)block;

@end
