//
//  GD_EvaluativeCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class GoodsDetailEvaluativeModel;

@protocol  GD_EvaluativeCellDelegate<NSObject>

/**  点击头像 */
- (void)GD_EvaluativeCellDelegate_clickIconWithModel:(GoodsDetailEvaluativeModel *)model;
/**  点赞 */
- (void)GD_EvaluativeCellDelegate_clickLike;
/**  二级评论 */
- (void)GD_EvaluativeCellDelegate_clickSecondComment;

@end

@interface GD_EvaluativeCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) GoodsDetailEvaluativeModel * model;
/**  代理*/
@property (nonatomic,weak) id <GD_EvaluativeCellDelegate> delegate;
@end
