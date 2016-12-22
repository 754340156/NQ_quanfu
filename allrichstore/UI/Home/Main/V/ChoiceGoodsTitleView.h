//
//  ChoiceGoodsTitleView.h
//  allrichstore
//
//  Created by zhaozhe on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoiceGoodsTitleViewDelegate <NSObject>
/**  点击按钮 */
- (void)ChoiceGoodsTitleViewDelegate_clickBtn:(UIButton * _Nonnull)sender;
@end


@interface ChoiceGoodsTitleView : UIScrollView
/**
 *  初始化方法
 *
 *  @param titleArr  传入的title数组
 *  @param isScroll 是否滚动
 *  @param contentSize contentSize
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame TitlesArr:( NSArray<NSString *> * _Nonnull )titleArr IsScroll:(BOOL)isScroll contentSize:(CGSize )contentSize;
/**  代理*/
@property (nonatomic, weak) id <ChoiceGoodsTitleViewDelegate>  titleDelegate;
@end
