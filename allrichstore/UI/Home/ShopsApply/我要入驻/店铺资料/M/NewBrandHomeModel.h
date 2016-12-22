//
//  NewBrandHomeModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/12/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface NewBrandHomeModel : BaseModel
/**  品牌名称 */
@property(nonatomic,copy) NSString * name;
/**  品牌logo */
@property(nonatomic,copy) NSString * logoImage;
/**  注册人 */
@property(nonatomic,copy) NSString * person;
/**  是否是第一行 */
@property(nonatomic,assign) BOOL isTitle;

@end
