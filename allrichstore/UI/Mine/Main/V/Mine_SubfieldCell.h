//
//  Mine_SubfieldCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol Mine_SubfieldCellDelegate <NSObject>

/**  点击button */
- (void)Mine_SubfieldCellDelegate_clickButtonWithIndex:(NSInteger)index Button:(UIButton *)sender;
@end

@interface Mine_SubfieldCell : BaseTableViewCell
/**  代理*/
@property (nonatomic,weak) id <Mine_SubfieldCellDelegate> delegate;
@end
