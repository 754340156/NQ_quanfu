//
//  SendCommentMainCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
#define kItemWidth 70.0f
#define kItemHeight 50.0f
//一行的数量
#define singleLineCount 3
//最多上传
#define maxCount 3
@class SendCommentShopModel,SendCommentMainCell;

@protocol SendCommentMainCellDelegate <NSObject>

/** 点击ButtonView  */
- (void)SendCommentMainCellDelegate_clickButtonViewWithSendCommentMainCell:(SendCommentMainCell *)cell Index:(NSInteger )index;

@end

@interface SendCommentMainCell : BaseTableViewCell
/**  model */
@property (nonatomic,strong) SendCommentShopModel * model;
/**  代理*/
@property (nonatomic,weak) id <SendCommentMainCellDelegate> delegate;
/**  点击星星 */
@property (nonatomic,copy) void(^clickStarBlock) (NSInteger count);
/**  添加照片 */
@property(nonatomic,strong) UICollectionView * collectionView;
@end
