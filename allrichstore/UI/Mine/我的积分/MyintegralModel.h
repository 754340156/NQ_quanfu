//
//  MyintegralModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
@class MyintegralDetailModel;
@interface MyintegralModel : BaseModel
/**  title */
@property(nonatomic,copy) NSString * comment;
/**  time */
@property(nonatomic,copy) NSString * createTime;
/**  积分 */
@property(nonatomic,copy) NSString * integral;
/**  加还是减0+ 1- */
@property(nonatomic,copy) NSString * type;
@end

