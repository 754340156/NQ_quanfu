//
//  SendCommentShopCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class SendCommentModel;
@interface SendCommentShopCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) SendCommentModel * model;
/**  点击星星1 */
@property(nonatomic,copy) void(^clickStarBlock1) (NSInteger count);
/**  点击星星2 */
@property(nonatomic,copy) void(^clickStarBlock2) (NSInteger count);

@end
