//
//  GD_EvaluativeHeaderView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GD_EvaluativeHeaderView : UITableViewHeaderFooterView
/**  总评价数 */
@property(nonatomic,copy) NSString * totalCount;
/**  好评率 */
@property(nonatomic,copy) NSString * rate;

@end
