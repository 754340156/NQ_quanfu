//
//  GoodsOneListSecondStyleCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsOneListSecondStyleCell.h"

@implementation GoodsOneListSecondStyleCell

//隐藏掉 好评率
//重写添加视图的方法
- (void)createViews
{
    [super createViews];
    self.praiseRateLabel.hidden = YES;
}

@end
