//
//  GoodsListFirstStyleVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

/*第一种样式的商品列表控制器*/
@interface GoodsListFirstStyleVC : BaseVC

@property (nonatomic, copy) NSString *cId;
@property (nonatomic, copy) NSString *cField;
@property (nonatomic, copy) NSString *inType;

//右侧添加搜索按钮
- (void)addSearchBtn;

@end
