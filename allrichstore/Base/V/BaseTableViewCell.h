//
//  BaseTableViewCell.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/21.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CellBtnStyle)
{
    CellBtnStyle_Play = 1,
    CellBtnStyle_Share,
    CellBtnStyle_Comment,
    CellBtnStyle_Like,
    CellBtnStyle_DisLike,
};

@interface BaseTableViewCell : UITableViewCell
{
    UIButton *_imgBtn;          //展示图标的btn
    UIImageView *_imgView;      //展示图片的imageView
    UILabel  *_titleLabel;      //展示标题的label
    UILabel  *_contentLabel;    //展示内容的label
    UILabel  *_timeLabel;       //展示时间的label
    UILabel  *_stateLabel;      //展示当前状态的

    BOOL _isHaveSeleBgView;      //是否有选中背景色
    UIColor *_seleBgColor;       //选中背景色的颜色
    
    BOOL _isHaveHighlightColor;  //是否有高亮背景色
    UIColor *_highlightBgColor;  //高亮时的背景颜色
    
    BOOL      _isEditState;     //是否是编辑状态
}

@property (nonatomic, strong) UIButton *imgBtn;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) CGFloat bottomLeftMargin;
@property (nonatomic, assign) CGFloat bottomRightMargin;

@property (nonatomic, assign) CGFloat bottomHeight;
@property (nonatomic, strong) UIColor *boottomLineColor;

@property (nonatomic, assign) BOOL isHaveSeleBgView;
@property (nonatomic, strong) UIColor *seleBgColor;

@property (nonatomic, assign) BOOL isHaveHighlightColor;
@property (nonatomic, strong) UIColor *highlightBgColor;

@property (nonatomic, assign) BOOL isEditState;

- (void)createViews;
- (void)layoutViews;

+ (CGFloat)cellHeight;

@end
