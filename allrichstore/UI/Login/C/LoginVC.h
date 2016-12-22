//
//  LoginVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

@interface LoginVC : BaseVC
/**  登录成功回调 */
@property(nonatomic,copy) void (^loginSuccessBlock)();
@end
