//
//  PulldownMoreView.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PulldownMoreView;
//配置的block
typedef void(^PulldownMoreViewConfigureBlock)(PulldownMoreView *pulldownMoreView);

//事件触发的blcok
typedef void(^PulldownMoreViewSelectedBlock)(NSInteger selectedIndex);

@protocol PulldownMoreViewDelegate <NSObject>

@end

@protocol PulldownMoreModelAble <NSObject>

- (NSString *)title;

@end

@interface PulldownMoreView : UIView

/**
 传数组和（配置，触发的block）的初始化
 @param menuArray 模型数组
 @param configureBlcok 配置块
 @param actionBlock 触发块
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuArray:(NSMutableArray *)menuArray
               configureBlcok:(PulldownMoreViewConfigureBlock)configureBlcok
                  actionBlock:(PulldownMoreViewSelectedBlock)actionBlock;

@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, assign) id<PulldownMoreViewDelegate> delegate;

@property (nonatomic, assign) NSInteger showCellMaxCount;
@property (nonatomic, assign) NSInteger moreShowCellMaxCount;
@property (nonatomic, strong) UIColor *cell_normalColor;
@property (nonatomic, strong) UIColor *cell_selectedColor;

//展示前几个的collectionView
@property (nonatomic, strong) UICollectionView *collectView;
//展示更多的collectionView
@property (nonatomic, strong) UICollectionView *moreCollectView;

@end


#pragma mark - cell
//展示前几个的cell
@interface PulldownCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *btn;

@end

#pragma mark - 展示更多的cell
//展示更多的cell
@interface PulldownMoreCell : UICollectionViewCell

@property (nonatomic, strong) QButton *btn;

@end
