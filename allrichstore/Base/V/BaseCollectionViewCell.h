//
//  BaseCollectionViewCell.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/21.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell
{
    UIView *_bgView;             //用于作为背景图
    UIButton *_imgBtn;          //展示图标的btn
    UIImageView *_imgView;      //展示图片的imageView
    UILabel  *_titleLabel;      //展示标题的label
    UILabel  *_contentLabel;    //展示内容的label
    UILabel  *_timeLabel;       //展示时间的label
    
    BOOL _isHaveSeleBgView;      //是否有选中背景色
    UIColor *_seleBgColor;       //选中背景色的颜色
    
    BOOL _isHaveHighlightColor;  //是否有高亮背景色
    UIColor *_highlightBgColor;  //高亮时的背景颜色
}

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *imgBtn;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, assign) BOOL isHaveSeleBgView;
@property (nonatomic, strong) UIColor *seleBgColor;

@property (nonatomic, assign) BOOL isHaveHighlightColor;
@property (nonatomic, strong) UIColor *highlightBgColor;

- (void)createViews;
- (void)layoutViews;

+ (CGFloat)cellHeight;

@end
