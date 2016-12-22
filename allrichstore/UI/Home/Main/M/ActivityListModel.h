//
//  ActivityListModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@class ActivitySubModel;
@interface ActivityListModel : BaseModel

@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *am_name;
@property (nonatomic, strong) NSArray<ActivitySubModel *> *categroylist;

@end

@interface ActivitySubModel: BaseModel

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *c_img_url;
@property (nonatomic, copy) NSString *c_name;

@end
