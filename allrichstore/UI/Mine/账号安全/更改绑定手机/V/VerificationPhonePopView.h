//
//  VerificationPhonePopView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerificationPhonePopViewDelegate <NSObject>

/**  点击获取验证码 */
- (void)VerificationPhonePopViewDelegate_clickGetCodeWithButton:(UIButton *)sender;
/**  点击确定or取消 */
- (void)VerificationPhonePopViewDelegate_clickSure:(BOOL)isSure;
@end

@interface VerificationPhonePopView : UIView
/**  代理*/
@property (nonatomic,weak) id <VerificationPhonePopViewDelegate> delegate;
/**  textfield */
@property(nonatomic,strong) UITextField * textfield;
/**  电话号码 */
@property(nonatomic,copy) NSString * phone;
/**  传入控制器 */
@property(nonatomic,weak) BaseVC * superViewController;
@end
