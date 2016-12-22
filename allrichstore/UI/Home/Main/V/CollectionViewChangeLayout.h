//
//  CollectionViewChangeLayout.h
//  allrichstore
//
//  Created by zhaozhe on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ChangeLayoutType) {
    ChangeLayoutList,//列表样式
    ChangeLayoutHorizontal //水平tableView样式
};
@interface CollectionViewChangeLayout : UICollectionViewFlowLayout

/**  样式选择 */
@property(nonatomic,assign) ChangeLayoutType  type;
/**  初始化方法指定默认样式 */
- (instancetype)initWithType:(ChangeLayoutType )type;
@end
