//
//  GoodsFilterVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsFilterVC.h"   //商品筛选控制器

@interface GoodsFilterVC ()

@property (nonatomic, strong) id<GoodsFilterAble> model;
@property (nonatomic, copy) CompleteBlock completeBlock;

@end

@implementation GoodsFilterVC

- (instancetype)initWithSlideType:(SlideType)slideType model:(id<GoodsFilterAble>)model completeBlock:(CompleteBlock)completeBlock
{
    self = [super initWithSlideType:SlideTypeFromRight];
    if (self)
    {
        self.model = model;
        self.completeBlock = completeBlock;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    GoodsFilterView *goodsFilterView = [[GoodsFilterView alloc] initWithFrame:CGRectMake(0, 20, self.windowView.width, self.windowView.height - 20)  model:self.model completeBlock:^(id<GoodsFilterAble> resultObject) {
        
        _completeBlock(resultObject);
        [weakSelf dismissWindowViewCompletion:nil];
    }];
    [self.windowView addSubview:goodsFilterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
