//
//  ThreeClassModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface ThreeClassModel : BaseModel
/**  title */
@property(nonatomic,copy) NSString * title;
/**  是否选中 */
@property(nonatomic,assign) BOOL  isSelected;

@end
