//
//  Log.h
//  FullRich
//
//  Created by 任强宾 on 16/10/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef Log_h
#define Log_h

//让NSLog在debug模式下有效, release模式下失效
#ifdef DEBUG
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
    #define NSLog(...)
#endif
//我的订单页面的枚举
typedef NS_ENUM(NSInteger, MyOrderVCStyle) {
    MyOrderVCWaitPay, //待付款
    MyOrderVCWaitSend, //待发货
    MyOrderVCWaitAccept, //待收货
    MyOrderVCWaitComment,//待评价
    MyOrderVCFinish//已完成
};
#endif /* Log_h */
