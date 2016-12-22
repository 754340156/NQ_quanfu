//
//  ThirdPartyBindingView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThirdPartyBindingViewDelegate <NSObject>
/**  解除绑定 */
- (void)ThirdPartyBindingViewDelegate_clickCancelBinding;

@end

@interface ThirdPartyBindingView : UIView
/**  代理*/
@property (nonatomic,weak) id <ThirdPartyBindingViewDelegate> delegate;
@end
