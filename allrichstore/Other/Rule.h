//
//  Rule.h
//  FullRich
//
//  Created by 任强宾 on 16/10/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef Rule_h
#define Rule_h

/*********************字符长度********************/
#define MaxLength_Title     16  //标题的最大长度
#define Length_verifiCode   6   //短信验证码的长度

#define Length_password_min 6   //密码的最短位数
#define Length_password_max 18  //密码的最长位数

/*********************数字大小********************/
//请求列表每页的大小
#define PageSize_list    10


/*********************时间长度********************/
#define TimeDuration_SendPraise  0.3
#define TimeDuration_RefreshPraise 0.2

//提示语显示后跳转的时间
#define TimeDuration_ToastMsg 1.6

#endif /* Rule_h */
