//
//  NewBrandHomeView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewBrandHomeViewDelegate <NSObject>
/**  检索 */
- (void)NewBrandHomeViewDelegate_clickSearchWithFinish:(void(^)(NSInteger arrayCount))uptateBlock;
/**  直接提交品牌信息 */
- (void)NewBrandHomeViewDelegate_clickSubmit;
/**  没有检索到申请的品牌 */
- (void)NewBrandHomeViewDelegate_clickNoSearch;
@end

@interface NewBrandHomeView : UIView
/**   */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**  代理*/
@property (nonatomic,weak) id <NewBrandHomeViewDelegate> delegate;
@end
