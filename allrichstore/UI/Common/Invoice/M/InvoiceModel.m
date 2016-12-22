//
//  InvoiceModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "InvoiceModel.h"    //发票信息的model

@implementation InvoiceModel

- (id)copyWithZone:(NSZone *)zone
{
    InvoiceModel *model = [[[self class] allocWithZone:zone] init];
    model.type = self.type;
    model.header = self.header;
    model.identifierCode = self.identifierCode;
    model.registerAddress = self.registerAddress;
    model.registerTel = self.registerTel;
    model.accountBank = self.accountBank;
    model.accountNum = self.accountNum;
    model.containArray = [self.containArray mutableCopy];
    return model;
}

@end
