//
//  ChangeEmailView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeEmailViewDelegate <NSObject>

/**  点击获取验证码 */
- (void)ChangeEmailViewDelegate_clickVerificationCodeBtnWithButton:(UIButton *)sender;
/**  点击完成 */
- (void)ChangeEmailViewDelegate_clickFinishButton;
@end

@interface ChangeEmailView : UIView
/**  邮箱 */
@property(nonatomic,strong) UITextField * passwordTF;
/**  验证码 */
@property(nonatomic,strong) UITextField * verificationCodeTF;
/**  代理*/
@property (nonatomic,weak) id <ChangeEmailViewDelegate> delegate;
@end
