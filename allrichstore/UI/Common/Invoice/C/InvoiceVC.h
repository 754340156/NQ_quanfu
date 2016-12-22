//
//  InvoiceVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"
#import "InvoiceModel.h"    //发票信息model

typedef void(^InvoiceBlock)(InvoiceModel *invoiceModel);

@interface InvoiceVC : BaseVC

//发票block：返回一个下单方选择好的发票信息model
- (instancetype)initWithModel:(InvoiceModel *)model invoiceBlock:(InvoiceBlock)invoiceBlock;

@end
