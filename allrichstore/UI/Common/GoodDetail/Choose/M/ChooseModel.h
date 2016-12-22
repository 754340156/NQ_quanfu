//
//  ChooseModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
@class ChooseModelProperty,ChooseModelImage,ChooseModelPropertyDetail;
@interface ChooseModel : BaseModel
/**  商品图片 */
@property(nonatomic,strong) NSArray <ChooseModelImage * > * goodimage;
/**  商品名 */
@property(nonatomic,copy) NSString * title;
/**  标题数据 */
@property(nonatomic,strong) NSArray <ChooseModelProperty * >* property;
@end


@interface ChooseModelProperty : BaseModel
/**  属性标题 */
@property(nonatomic,copy) NSString * gpv_property;
/**  属性id */
@property(nonatomic,copy) NSString * gpv_propertyid;
/**  属性数组 */
@property(nonatomic,strong) NSArray <ChooseModelPropertyDetail *>* code;
/**  属性数组（处理后的数组，只有属性名） */
@property(nonatomic,strong) NSArray * buttonsArray;
/**  属性英文名 */
@property(nonatomic,copy) NSString * gp_code;
@end

@interface ChooseModelImage : BaseModel
/**  url */
@property(nonatomic,copy) NSString * g_imgurl;
@end

@interface ChooseModelPropertyDetail : BaseModel
/**  属性名 */
@property(nonatomic,copy) NSString * gpv_propertyvalue;
/**  属性标题id */
@property(nonatomic,copy) NSString * gpv_propertyid;
/**  属性id */
@property(nonatomic,copy) NSString * gpv_propertyvalueid;
/**  商品id */
@property(nonatomic,copy) NSString * gpv_goodid;
@end

