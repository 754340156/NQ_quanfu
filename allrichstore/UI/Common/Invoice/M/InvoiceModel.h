//
//  InvoiceModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, InvoiceType)
{
    InvoiceTypeOrdinaryPersonal = 0,    //普通（个人）
    InvoiceTypeOrdinaryCompany,         //普通（公司）
    InvoiceTypeAddedTax,                //增值税
    InvoiceTypeNotNeed                  //不要发票
};

@interface InvoiceModel : NSObject<NSCopying>

//发票类型
@property (nonatomic, assign) InvoiceType type;

//发票抬头
@property (nonatomic, copy) NSString *header;
//纳税人识别码
@property (nonatomic, copy) NSString *identifierCode;
//注册地址
@property (nonatomic, copy) NSString *registerAddress;
//注册电话
@property (nonatomic, copy) NSString *registerTel;
//开户银行
@property (nonatomic, copy) NSString *accountBank;
//银行账户
@property (nonatomic, copy) NSString *accountNum;
//发票内容数组
@property (nonatomic, strong) NSMutableArray *containArray;


@end
