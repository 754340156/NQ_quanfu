//
//  GoodsDetailSecondView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GD_SecondTableView.h"
@interface GoodsDetailSecondView : UIView
/**  <#注释#> */
@property(nonatomic,strong) UIScrollView * scrollView;
/**  传入父控制器 */
@property(nonatomic,weak) UIViewController <UITableViewDelegate>* superVC;
/**  装入tableView数组 */
@property(nonatomic,strong) NSMutableArray * viewsArray;
@end
