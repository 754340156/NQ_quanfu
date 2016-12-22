//
//  Pay_CheckDeskModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface Pay_CheckDeskModel : BaseModel
/**  icon */
@property(nonatomic,copy) NSString * icon;
/**  title */
@property(nonatomic,copy) NSString * title;
/**  是否选中 */
@property(nonatomic,assign) BOOL  isSelected;

@end
