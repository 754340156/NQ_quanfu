//
//  ThreeClassVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ThreeClassVC.h"
#import "ThreeClassCell.h"
#import "ThreeClassModel.h"
#import "ManageClassModel.h"
@interface ThreeClassVC ()
/**  记录选中的数组 */
@property(nonatomic,strong) NSMutableArray * selectedArray;
@end

@implementation ThreeClassVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    NSArray *array = @[@{@"title":@"衬衫"},
                       @{@"title":@"T恤"},
                       @{@"title":@"织针衫"},
                       @{@"title":@"风衣"},
                       @{@"title":@"内衣"},
                       @{@"title":@"衬衫"},
                       @{@"title":@"T恤"},
                       @{@"title":@"织针衫"},
                       @{@"title":@"风衣"},
                       @{@"title":@"内衣"},
                       @{@"title":@"衬衫"},
                       @{@"title":@"T恤"},
                       @{@"title":@"织针衫"},
                       @{@"title":@"风衣"},
                       @{@"title":@"内衣"},
                       @{@"title":@"衬衫"},
                       @{@"title":@"T恤"},
                       @{@"title":@"织针衫"},
                       @{@"title":@"风衣"},
                       @{@"title":@"内衣"}];
    self.listArray = [ThreeClassModel mj_objectArrayWithKeyValuesArray:array];
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    [self addRightTitle:@"保存" action:@selector(saveAction)];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[ThreeClassCell class] forCellReuseIdentifier:[ThreeClassCell className]];
    
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
- (void)saveAction
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in self.selectedArray) {
        ManageClassModel *model = [[ManageClassModel alloc] init];
        model.firstClass = self.firstClass;
        model.secondClass = self.secondClass;
        model.threeClass = str;
        [array addObject:model];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kShopInformationAddClass object:array];
    [self dismissVCAnimated:YES completion:nil];
}
#pragma mark - <UITableViewDataSource>
//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThreeClassCell *cell = [tableView dequeueReusableCellWithIdentifier:[ThreeClassCell className] forIndexPath:indexPath];
    ThreeClassModel *model = self.listArray[indexPath.row];
    cell.model = model;
    cell.clickSelected = ^(BOOL isSelected)
    {
        model.isSelected = isSelected;
        //记录选中model
        if (isSelected) {
            [self.selectedArray addObject:model.title];
        }else
        {
            [self.selectedArray removeObject:model.title];
        }
    };
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
#pragma mark - lazy
- (NSMutableArray *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}



@end
