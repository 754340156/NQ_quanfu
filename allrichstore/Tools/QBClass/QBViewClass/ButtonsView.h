//
//  ButtonsView.h
//  AmapRoutePlanning
//
//  Created by 任强宾 on 16/5/6.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonsView;
@protocol ButtonsViewDelegate <NSObject>

- (void)btsView:(ButtonsView *)btnView IsClicked:(UIButton *)btn atIndex:(NSInteger)index isRepeatTouch:(BOOL)isRepeatTouch;

@end

@interface ButtonsView : UIView

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, assign) id<ButtonsViewDelegate> delegate;

@property (nonatomic, assign) BOOL isFullWidth;

//是否是在选中的状态下点击
@property (nonatomic, assign) BOOL isRepeatTouch;

//按钮的个数
@property (nonatomic, assign) NSInteger btnCount;
@property (nonatomic, assign) CGFloat btnWidth;

//按钮的渲染颜色
@property (nonatomic, strong) UIColor *btnTintColor;

//标题的字体
@property (nonatomic, strong) UIFont *titleFont;

//滑动条的高度
@property (nonatomic, assign) CGFloat slideBarHeight;
//滑动条的宽度
@property (nonatomic, assign) CGFloat slideBarWidth;
//滑动条的颜色
@property (nonatomic, strong) UIColor *slideBarColor;
//滑动条的上偏移
@property (nonatomic, assign) CGFloat slideBarOffSetH;

//分割条的宽度
@property (nonatomic, assign) CGFloat splitWidth;
//分割条的边距
@property (nonatomic, assign) CGFloat splitMargin;
//分割条的颜色
@property (nonatomic, strong) UIColor *splitColor;
//上下

@property (nonatomic, strong) UIImage *sliderImage;

//自定义 标题型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles;

//自定义 标题型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor;

//自定义 标题型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
                selectedColor:(UIColor *)seletedColor;

//自定义 标题型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
                selectedColor:(UIColor *)seletedColor
                    titleFont:(UIFont *)titleFont;

//自定义 图标型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                 normalImages:(NSArray *)normalImages
                   imageWidth:(CGFloat)imageWidth
                  imageHeight:(CGFloat)imageHeight;

//自定义 图标型按钮（单选中） 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                  normalImages:(NSArray *)normalImages
                selectedImages:(NSArray *)selectedImages
                   imageWidth:(CGFloat)imageWidth
                  imageHeight:(CGFloat)imageHeight;

//自定义 图标型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
                 normalImages:(NSArray *)normalImages
                        style:(QButtonStyle)style
                        space:(CGFloat)space;

//自定义 图标型按钮（单选中） 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
                selectedColor:(UIColor *)seletedColor
                 normalImages:(NSArray *)normalImages
               selectedImages:(NSArray *)selectedImages
                        style:(QButtonStyle)style
                        space:(CGFloat)space;

//选中图片按钮的触发事件
- (void)handleImageBtn:(UIButton *)sender;

//选中标题按钮的触发事件
- (void)selectBtn:(UIButton *)sender;

//根据按钮，计算按钮下边的滑条的frame
- (CGRect)getSlideFrameUnderBtn:(UIButton *)btn;

@end
