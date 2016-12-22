//
//  GoodsDetailChooseView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseModel;
@protocol GoodsDetailChooseViewDelegate <NSObject>
/**  点击确定传出标签数组 */
- (void)GoodsDetailChooseViewDelegate_clickSureActionWithArray:(NSArray *)array;
@end

@interface GoodsDetailChooseView : UIView
/**  代理*/
@property (nonatomic,weak) id <GoodsDetailChooseViewDelegate> delegate;
/**  设置数据 */
- (void)setChooseModelWithModel:(ChooseModel *)model;

@end
