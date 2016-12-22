//
//  EnterDelegateView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EnterDelegateViewDelegate <NSObject>

/**  点击申请入驻 */
- (void)EnterDelegateViewDelegate_clickApply;

@end


@interface EnterDelegateView : UIView
/**  代理*/
@property (nonatomic,weak) id <EnterDelegateViewDelegate> delegate;
@end
