//
//  ThirdLoginVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

@interface ThirdLoginVC : BaseVC

//第三方登录的类型
@property (nonatomic, assign) ThirdLoginType thirdLoginType;
//第三方登录的昵称
@property (nonatomic, copy) NSString *thirdNickName;

@end
