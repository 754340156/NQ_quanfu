//
//  ProfessionModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/12.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface ProfessionModel : BaseModel<QBPickerViewAble>

@property (nonatomic, assign) long in_id;
@property (nonatomic, copy) NSString *in_name;
@property (nonatomic, strong) NSArray<ProfessionModel *> *list;

@end
