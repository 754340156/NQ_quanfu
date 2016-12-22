//
//  MyCollection_ShopsModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface MyCollection_ShopsModel : BaseModel
/**  大图 */
@property(nonatomic,copy) NSString * s_headimage;
/**  title */
@property(nonatomic,copy) NSString * s_name;
/**  评分 */
@property(nonatomic,copy) NSString * score;
/**  店铺id */
@property(nonatomic,copy) NSString * s_score;
@end
