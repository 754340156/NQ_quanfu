//
//  CommentHeaderCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CommentHeaderCellDelegate <NSObject>

/**  点击按钮 */
- (void)CommentHeaderCellDelegate_clickButtonWithButton:(UIButton *)sender Index:(NSInteger)index;

@end

@interface CommentHeaderCell : BaseTableViewCell
/**  按钮数组 */
@property(nonatomic,strong) NSArray * btnArray;
/**  代理*/
@property (nonatomic,weak) id <CommentHeaderCellDelegate> delegate;
@end
