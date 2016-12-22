//
//  MyOrderDetailBottomView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBottomViewH 45.0f
typedef NS_ENUM(NSInteger, MyOrderDetailBottomButtonTitle) {
    MyOrderDetailBottomButtonTitleCancel, //取消订单
    MyOrderDetailBottomButtonTitleDelete, //删除订单
    MyOrderDetailBottomButtonTitleLogistic, //查看物流
    MyOrderDetailBottomButtonTitletRefund,//退款售后
    MyOrderDetailBottomButtonTitlePay, //付款
    MyOrderDetailBottomButtonTitleAgainBuy, //再次购买
    MyOrderDetailBottomButtonTitleSureGet, //确认收货
    MyOrderDetailBottomButtonTitleComment //评价
};
@protocol MyOrderDetailBottomViewDelegate <NSObject>

- (void)MyOrderDetailBottomViewDelegate_clickButtonWithTitleStyle:(MyOrderDetailBottomButtonTitle)titleStyle;

@end

@interface MyOrderDetailBottomView : UIView
/**  初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame Style:(MyOrderVCStyle)style;
/**  代理*/
@property (nonatomic,weak) id <MyOrderDetailBottomViewDelegate> delegate;
@end
