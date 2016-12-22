//
//  PulldownView.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/4.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PulldownViewDelegate <NSObject>


@end

@class PulldownModel;
@interface PulldownView : UIView
{
    UIColor *_oneMenuCell_NormalColor;  //一级菜单正常色
    UIColor *_oneMenuCell_SelectedColor;//一级菜单选中色
    UIColor *_twoMenuCell_NormalColor;  //二级菜单正常色
    UIColor *_twoMenuCell_SelectedColor;//二级菜单选中色
    
    UIImageView *_bottomLineView;  //一级菜单底部的滑条
    
    BOOL _isMultiselect;   //是否是多选
}

/**
 二级下拉菜单
 @param frame 初始frame
 @param menuModel 菜单数据源model
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuModel:(PulldownModel *)menuModel;


@property (nonatomic, strong) PulldownModel *menuModel;
@property (nonatomic, assign) id<PulldownViewDelegate> delegate;

@property (nonatomic, strong) UIColor *oneMenuCell_NormalColor;
@property (nonatomic, strong) UIColor *oneMenuCell_SelectedColor;
@property (nonatomic, strong) UIColor *twoMenuCell_NormalColor;
@property (nonatomic, strong) UIColor *twoMenuCell_SelectedColor;

@property (nonatomic, strong) UIImageView *bottomLineView;  //一级菜单底部的滑条

//滑动条的高度
@property (nonatomic, assign) CGFloat slideBarHeight;
//滑动条的宽度
@property (nonatomic, assign) CGFloat slideBarWidth;
//滑动条的颜色
@property (nonatomic, strong) UIColor *slideBarColor;
//滑动条的上偏移
@property (nonatomic, assign) CGFloat slideBarOffSetH;
//滑条的图片
@property (nonatomic, strong) UIImage *sliderImage;

@property (nonatomic, assign) BOOL isMultiselect;


//配置参数
- (void)configParams;

//一级菜单的collectionView
@property (nonatomic, strong) UICollectionView *oneLevelCollectView;
//二级菜单的collectionView
@property (nonatomic, strong) UICollectionView *twoLevelCollectView;

@end


@interface CellButton : UIButton

@end

#pragma mark - 一级菜单的cell
//一级菜单的cell
@interface PulldownOneMenuCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *btn;

@end

#pragma mark - 二级菜单的cell
//二级菜单的cell
@interface PulldownTwoMenuCell : UICollectionViewCell

@property (nonatomic, strong) CellButton *btn;

@end

#pragma mark - 菜单的model
//二级筛选

@class OneMenuModel, TwoMenuModel;
@interface PulldownModel : NSObject

@property (nonatomic, strong) NSArray<OneMenuModel *> *oneMenuArray;
@property (nonatomic, copy) NSString *menuTitle;

@end


@interface OneMenuModel : NSObject

@property (nonatomic, strong) NSArray<TwoMenuModel *> *twoMenuArray;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@end


@interface TwoMenuModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@end
