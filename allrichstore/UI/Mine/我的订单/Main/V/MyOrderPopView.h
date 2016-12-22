//
//  MyOrderPopView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyOrderPopViewDelegate <NSObject>
/**  点击buttonView上面的Button */
- (void)MyOrderPopViewDelegate_clickWithButton:(QButton *)sender;
/**  点击整个popView */
- (void)MyOrderPopViewDelegate_clickPopView;
@end

@interface MyOrderPopView : UIView
/**
 *  初始化方法
 *
 *  @param frame  <#param#>
 *  @param titleArray 图标文字数组
 *  @param imageArray 图标图片数组
 */
- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray SeletedImageA:(NSArray *)seletedImageA;
/**  点击展示 */
- (void)show;
/**  点击隐藏 */
- (void)hidden;
/**  代理*/
@property (nonatomic,weak) id <MyOrderPopViewDelegate> delegate;
@end
