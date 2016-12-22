//
//  ManageClassModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface ManageClassModel : BaseModel
/**  序号 */
@property(nonatomic,copy) NSString *  index;
/**  一级类别 */
@property(nonatomic,copy) NSString * firstClass;
/**  二级类别 */
@property(nonatomic,copy) NSString * secondClass;
/**  三级类别 */
@property(nonatomic,copy) NSString * threeClass;
/**  是否是第一行 */
@property(nonatomic,assign) BOOL isTitle;

@end
