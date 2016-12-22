//
//  ShoppingCartBottomView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBottomViewH 50.0f

@protocol ShoppingCartBottomViewDelegate <NSObject>
/**  结算 */
- (void)ShoppingCartBottomViewDelegate_clickSettlementBtn;
/**  移入关注 */
- (void)ShoppingCartBottomViewDelegate_clickToCareBtn;
/**  删除 */
- (void)ShoppingCartBottomViewDelegate_clickDeleteButton;
@end

@interface ShoppingCartBottomView : UIView
/**  全选按钮 */
@property(nonatomic,strong) QButton * allButton;
/**  合计 */
@property(nonatomic,strong) UILabel * totalLabel;
/**  合计下面的副标题 */
@property(nonatomic,strong) UILabel * subTitleLabel;
/**  代理*/
@property (nonatomic,weak) id <ShoppingCartBottomViewDelegate> delegate;
/**  全选按钮block */
@property(nonatomic,copy) void (^clickAllButtonBlock)(QButton *sender);
/**  编辑状态 */
- (void)editStatus;
/**  正常状态 */
- (void)normalStatus;
@end
