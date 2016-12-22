//
//  NewBrandHomeVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NewBrandHomeVC.h"
#import "NewBrandHomeView.h"
#import "NewBrandHomeCell.h"
#import "NewBrandHomeModel.h"
#import "AddBrandVC.h"
@interface NewBrandHomeVC ()<NewBrandHomeViewDelegate>
/**  backView */
@property(nonatomic,strong) NewBrandHomeView * backView;
/**  品牌数组 */
@property(nonatomic,strong) NSMutableArray * brandArray;
@end

@implementation NewBrandHomeVC

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
    self.backView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NewBrandHomeView class]) owner:nil options:nil].firstObject;
    self.backView.delegate = self;
    self.backView.frame = kCommentRect;
    self.backView.tableView.delegate = self;
    self.backView.tableView.dataSource = self;
    [self.backView.tableView registerClass:[NewBrandHomeCell class] forCellReuseIdentifier:[NewBrandHomeCell className]];
    [self.view addSubview:self.backView];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
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
    NewBrandHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewBrandHomeCell className] forIndexPath:indexPath];
    if (indexPath.section == 0) {
        NewBrandHomeModel *model = [[NewBrandHomeModel alloc] init];
        model.name = @"品牌名称";
        model.logoImage = @"";
        model.isTitle = YES;
        model.person = @"商标注册人";
        cell.model = model;
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
#pragma mark - NewBrandHomeViewDelegate
/**  检索 */
- (void)NewBrandHomeViewDelegate_clickSearchWithFinish:(void(^)(NSInteger arrayCount))uptateBlock
{
    //点击检索到的品牌展示并更新约束
    NSArray *array = @[@{@"name":@"都市丽人",
                          @"logoImage":@"",
                          @"person":@"广东省都市丽人实业有限公司"},
                        @{@"name":@"都市丽人",
                          @"logoImage":@"",
                          @"person":@"广东省都市丽人实业有限公司"},
                        @{@"name":@"都市丽人",
                          @"logoImage":@"",
                          @"person":@"广东省都市丽人实业有限公司"}
                        ];
    self.brandArray = [NewBrandHomeModel mj_objectArrayWithKeyValuesArray:array];
    uptateBlock(self.brandArray.count + 1);
}
/**  直接提交品牌信息 */
- (void)NewBrandHomeViewDelegate_clickSubmit
{
    
}
/**  没有检索到申请的品牌 */
- (void)NewBrandHomeViewDelegate_clickNoSearch
{
    //没有检索到品牌就去添加
    AddBrandVC *addVC = [[AddBrandVC alloc] init];
    [self.navigationController pushVC:addVC animated:YES];
    
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
