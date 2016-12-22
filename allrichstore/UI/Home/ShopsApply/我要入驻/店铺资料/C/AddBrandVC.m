//
//  AddBrandVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddBrandVC.h"
#import "AddBrandView.h"
#import "AddBrandCell.h"
#import "AddBrandModel.h"
#import "NewBrandVC.h"
@interface AddBrandVC ()<AddBrandViewDelegate>
/**  backView */
@property(nonatomic,strong) AddBrandView * backView;
/**  品牌数组 */
@property(nonatomic,strong) NSMutableArray * brandArray;
@end

@implementation AddBrandVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    self.backView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AddBrandView class]) owner:nil options:nil].lastObject;
    self.backView.delegate = self;
    self.backView.tableView.delegate = self;
    self.backView.tableView.dataSource = self;
    self.backView.frame = kCommentRect;
    [self.backView.tableView registerClass:[AddBrandCell class] forCellReuseIdentifier:[AddBrandCell className]];
    [self.view addSubview:self.backView];
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0)return 1;
    return self.brandArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddBrandCell className] forIndexPath:indexPath];
    if (indexPath.section == 0) {
//        AddBrandModel *model = [[AddBrandModel alloc] init];
//        model.name = @"品牌名称";
//        model.logoImage = @"";
//        model.isTitle = YES;
//        model.person = @"商标注册人";
    }else
    {
        cell.model = self.brandArray[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kBottomH;
}
#pragma mark - AddBrandViewDelegate
//添加品牌
- (void)AddBrandViewDelegate_clickAddBrand
{
    NewBrandVC *brandVC = [[NewBrandVC alloc] init];
    [self.navigationController pushVC:brandVC animated:YES];
}
//提交
- (void)AddBrandViewDelegate_clickSubmit
{
    
}
#pragma mark - lazy
- (NSMutableArray *)brandArray
{
    if (!_brandArray) {
        _brandArray = [NSMutableArray array];
    }
    return _brandArray;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
