//
//  IncomeModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/12.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface IncomeModel : BaseModel<QBPickerViewAble, NSCoding>

@property (nonatomic, assign) long m_id;
@property (nonatomic, copy) NSString *m_income;

@end
