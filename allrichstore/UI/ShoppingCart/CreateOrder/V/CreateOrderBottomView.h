//
//  CreateOrderBottomView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateOrderBottomViewDelegate <NSObject>
/**  点击提交 */
- (void)CreateOrderBottomViewDelegate_clickSubmitBtn;

@end

@interface CreateOrderBottomView : UIView
/**  代理*/
@property (nonatomic,weak) id <CreateOrderBottomViewDelegate> delegate;
@end
