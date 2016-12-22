//
//  MyOrderSubmitSuccessView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyOrderSubmitSuccessViewDelegate <NSObject>
/**  查看进度 */
- (void)MyOrderSubmitSuccessViewDelegate_clickProgressSearch;
/**  售后首页 */
- (void)MyOrderSubmitSuccessViewDelegate_clickHome;
@end


@interface MyOrderSubmitSuccessView : UIView
/**  代理*/
@property (nonatomic,weak) id <MyOrderSubmitSuccessViewDelegate> delegate;
/**  申请时间 */
@property(nonatomic,copy) NSString * time;
@end
