//
//  HobbyModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@class HobbySubModel;
@interface HobbyModel : BaseModel

@property (nonatomic, copy) NSString *uh_hobbyid;
@property (nonatomic, copy) NSString *h_id;
@property (nonatomic, copy) NSString *h_name;
@property (nonatomic, strong) NSArray<HobbySubModel *> *list;

@end

@interface HobbySubModel : BaseModel

@property (nonatomic, copy) NSString *uh_hobbyid;
@property (nonatomic, copy) NSString *h_id;
@property (nonatomic, copy) NSString *h_name;
@property (nonatomic, assign) BOOL isSelected;

@end
