//
//  RefundDetailApplyModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/30.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface RefundDetailApplyModel : BaseModel
/**  商品title */
@property(nonatomic,copy) NSString * title;
/**  总数量 */
@property(nonatomic,copy) NSString * count;
/**  商品图片 */
@property(nonatomic,copy) NSString * icon;
/**  服务类型 */
@property(nonatomic,strong) NSArray * typeArray;
/**  选中的类型 */
@property(nonatomic,copy) NSString * currentType;
/**  申请的数量 */
@property(nonatomic,copy) NSString * applyCount;
/**  问题描述 */
@property(nonatomic,copy) NSString * problemDescription;
/**  上传照片的数组 */
@property(nonatomic,strong) NSArray * photoArray;
#pragma mark - 计算属性
/**  typeHeight */
@property(nonatomic,assign) CGFloat typeHeight;

@end
