//
//  GoodsClassModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/30.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@class TabMenuView;
@interface GoodsClassModel : NSObject<TabMenuModelAble, NSCoding>

@property (nonatomic, copy) NSString *cName;  //名称
@property (nonatomic, copy) NSString *cImgUrl;//图标地址
@property (nonatomic, assign) long cPid;     //
@property (nonatomic, assign) long cType;    //类型
@property (nonatomic, assign) long id;

@end
