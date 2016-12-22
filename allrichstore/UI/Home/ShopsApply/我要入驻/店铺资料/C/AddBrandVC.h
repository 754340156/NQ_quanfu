//
//  AddBrandVC.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

@interface AddBrandVC : BaseVC
/**  回调添加的品牌 */
@property(nonatomic,copy) void(^addBrandBlock)();
@end
