//
//  MyCashCounponModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface MyCashCounponModel : BaseModel
/**  创建时间 */
@property(nonatomic,copy) NSString * cpr_ceatetime;
/**  现金券金额 */
@property(nonatomic,copy) NSString * cpr_cash;
/**  商品名称 */
@property(nonatomic,copy) NSString * o_goodname;
/**  收入还是支出 */
@property(nonatomic,assign) BOOL isIncome;
@end

