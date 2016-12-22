//
//  SendCommentModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
#define kImageSize CGSizeMake(Adapted(70), Adapted(70))

#define kButtonViewH 60.0f
#define kStarViewH 25.0f
@class SendCommentShopModel;
@interface SendCommentModel : BaseModel
/**  商品评价数组 */
@property(nonatomic,strong) NSArray <SendCommentShopModel *> * shopsModel;
/**  客服态度 */
@property(nonatomic,assign) NSInteger  attitudeCount;
/**  物流速度 */
@property(nonatomic,assign) NSInteger  logisticsCount;

@end
@interface SendCommentShopModel : BaseModel
/**  商品图片 */
@property(nonatomic,copy) NSString * cover;
/**  评论 */
@property(nonatomic,copy) NSString * comment;
/**  图片数组 */
@property(nonatomic,strong) NSArray * picArray;
/**  好评中评差评 */
@property(nonatomic,assign) NSInteger  evaluateLevel;
/**  商品评价等级 */
@property(nonatomic,assign) NSInteger  evaluateStarLevel;
@end
