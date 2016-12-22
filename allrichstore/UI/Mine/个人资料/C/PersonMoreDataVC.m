//
//  PersonMoreDataVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "PersonMoreDataVC.h"    //更多资料控制器
#import "Person_TFCell.h"       //输入框cell
#import "IncomeModel.h"         //月收入model
#import "EducatModel.h"         //教育程度model
#import "ProfessionModel.h"     //职业的model

@interface PersonMoreDataVC ()

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy)   NSString *constellation;

//收入数组
@property (nonatomic, strong) NSMutableArray *incomeArray;
//学历数组
@property (nonatomic, strong) NSMutableArray *educatArray;
//所属行业数组
@property (nonatomic, strong) NSMutableArray *professionArray;

@end

@implementation PersonMoreDataVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    //更新数据源和tableView
    [self updateDataAndTableView];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.title = String(@"个人资料");
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[Person_TFCell class] forCellReuseIdentifier:[Person_TFCell className]];
    [self.view addSubview:_tableView];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - lazy
//月收入数组
- (NSMutableArray *)incomeArray
{
    if (!_incomeArray)
    {
        self.incomeArray = [Tools readFromSandBox:Key_PersonDataIncomeArray];
    }
    return _incomeArray;
}

//教育程度数组
- (NSMutableArray *)educatArray
{
    if (!_educatArray)
    {
        self.educatArray = [Tools readFromSandBox:Key_PersonDataEducatArray];
    }
    return _educatArray;
}

//所属行业数组
- (NSMutableArray *)professionArray
{
    if (!_professionArray)
    {
        self.professionArray = [Tools readFromSandBox:Key_PersonDataProfessionArray];
    }
    return _professionArray;
}

#pragma mark - request data
//请求月收入列表数据
- (void)requestIncomeList
{
    //如果缓存里面有数据，直接取缓存的展示
    if (_incomeArray.count > 0)
    {
        QBPickerView *qbPickerView = [[QBPickerView alloc] initWithStyle:QBPickerViewTypeHaveBtn dataArray:_incomeArray columnCount:1 action:^(NSArray *selectedArray) {
            
            //修改信息
            IncomeModel *incomeMode = _incomeArray[0];
            _userModel.uMonthpay = [NSString stringWithFormat:@"%ld", incomeMode.m_id];
            [self updateDataAndTableView];
            
        }];
        [qbPickerView selectIndexArray:[self incomeIndexArrayWithId:_userModel.uMonthpay]];
        [qbPickerView show];
        return;
    }
    
    //如果缓存里面没数据（请求完数据再展示）
    NSDictionary *parameters = @{@"type":@"2"};
    [self POST:API_MineDataGetAllList parameters:parameters success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        [self.incomeArray removeAllObjects];
        self.incomeArray = [IncomeModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:_incomeArray key:Key_PersonDataIncomeArray];
        QBPickerView *qbPickerView = [[QBPickerView alloc] initWithStyle:QBPickerViewTypeHaveBtn dataArray:_incomeArray columnCount:1 action:^(NSArray *selectedArray) {
            
            //修改信息
            IncomeModel *incomeMode = _incomeArray[0];
            _userModel.uMonthpay = [NSString stringWithFormat:@"%ld", incomeMode.m_id];
            [self updateDataAndTableView];
            
        }];
        [qbPickerView show];
        [qbPickerView selectIndexArray:[self incomeIndexArrayWithId:_userModel.uMonthpay]];
        
    } fail:^(NSError *error) {
        
    } sendView:self.view animSuperView:self.view animated:YES];
}

//请求教育程度列表数据
- (void)requestEducatList
{
    //如果缓存里面有数据，直接取缓存的展示
    if (_educatArray.count > 0)
    {
        QBPickerView *qbPickerView = [[QBPickerView alloc] initWithStyle:QBPickerViewTypeHaveBtn dataArray:_educatArray columnCount:1 action:^(NSArray *selectedArray) {
            
            //修改信息
            EducatModel *educatModel = selectedArray[0];
            _userModel.uEducation = [NSString stringWithFormat:@"%ld", educatModel.e_id];
            [self updateDataAndTableView];
            
        }];
        [qbPickerView selectIndexArray:[self educatIndexArrayWithId:_userModel.uEducation]];
        [qbPickerView show];
        return;
    }
    
    //如果缓存里面没数据（请求完数据再展示）
    NSDictionary *parameters = @{@"type":@"3"};
    [self POST:API_MineDataGetAllList parameters:parameters success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        [self.educatArray removeAllObjects];
        self.educatArray = [EducatModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:_educatArray key:Key_PersonDataEducatArray];
        QBPickerView *qbPickerView = [[QBPickerView alloc] initWithStyle:QBPickerViewTypeHaveBtn dataArray:_educatArray columnCount:1 action:^(NSArray *selectedArray) {
            
            //修改信息
            EducatModel *educatModel = selectedArray[0];
            _userModel.uEducation = [NSString stringWithFormat:@"%ld", educatModel.e_id];
            [self updateDataAndTableView];
            
        }];
        [qbPickerView selectIndexArray:[self educatIndexArrayWithId:_userModel.uEducation]];
        [qbPickerView show];
        
    } fail:^(NSError *error) {
        
    } sendView:self.view animSuperView:self.view animated:YES];
}

//请求行业列表数据
- (void)requestProfessionList
{
    //如果缓存里面有数据，直接取缓存的展示
    if (_professionArray.count > 0)
    {
        QBPickerView *qbPickerView = [[QBPickerView alloc] initWithStyle:QBPickerViewTypeHaveBtn dataArray:_professionArray columnCount:2 action:^(NSArray *selectedArray) {
            
            //修改信息
            ProfessionModel *professModel = selectedArray[1];
            _userModel.uProfession = professModel.ID;
            [self updateDataAndTableView];
            
        }];
        [qbPickerView selectIndexArray:[self professIndexArrayWithId:_userModel.uProfession]];
        [qbPickerView show];
        return;
    }
    
    NSDictionary *parameters = @{@"type":@"4"};
    [self POST:API_MineDataGetAllList parameters:parameters success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        [self.professionArray removeAllObjects];
        self.professionArray = [ProfessionModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:_professionArray key:Key_PersonDataProfessionArray];
        QBPickerView *qbPickerView = [[QBPickerView alloc] initWithStyle:QBPickerViewTypeHaveBtn dataArray:_professionArray columnCount:2 action:^(NSArray *selectedArray) {
            
            //修改信息
            ProfessionModel *professModel = selectedArray[1];
            _userModel.uProfession = professModel.ID;
            [self updateDataAndTableView];
            
        }];
        [qbPickerView selectIndexArray:[self professIndexArrayWithId:_userModel.uProfession]];
        [qbPickerView show];
        
        
    } fail:^(NSError *error) {
        
    } sendView:self.view animSuperView:self.view animated:YES];
}

#pragma mark - custom method
//婚姻状况格式化
- (NSString *)marriageFormatWithId:(NSString *)Id
{
    if ([Id isEqualToString:@"1"]) {
        return String(@"未婚");
    } else {
        return String(@"已婚");
    }
}

//月收入格式化
- (NSString *)incomeFormatWithId:(NSString *)Id
{
    NSArray *indexArray = [self incomeIndexArrayWithId:Id];
    if (!indexArray.count) {
        return @"";
    }
    NSInteger index = [indexArray[0] integerValue];
    IncomeModel *model = _incomeArray[index];
    return model.m_income;
}

//教育程度格式化
- (NSString *)educatFormatWithId:(NSString *)Id
{
    NSArray *indexArray = [self educatIndexArrayWithId:Id];
    if (!indexArray.count) {
        return @"";
    }
    NSInteger index = [indexArray[0] integerValue];
    EducatModel *model = _educatArray[index];
    return model.e_name;
}

//所属行业格式化
- (NSString *)professFormatWithId:(NSString *)Id
{
    NSArray *indexArray = [self professIndexArrayWithId:Id];
    if (!indexArray.count) {
        return @"";
    }
    NSInteger index = [indexArray[0] integerValue];
    ProfessionModel *model = _professionArray[index];
    NSInteger subIndex = [indexArray[1] integerValue];
    ProfessionModel *subModel = model.list[subIndex];
    return subModel.in_name;
}

//通过id从月收入列表筛出IndexArray
- (NSArray *)incomeIndexArrayWithId:(NSString *)Id
{
    __block NSInteger index = -1;
    [self.incomeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (((IncomeModel *)obj).m_id == [Id integerValue]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index < 0 ? @[] : @[@(index)];
}

//通过id从教育程度列表筛出IndexArray
- (NSArray *)educatIndexArrayWithId:(NSString *)Id
{
    __block NSInteger index = -1;
    [self.educatArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (((EducatModel *)obj).e_id == [Id integerValue]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index < 0 ? @[] : @[@(index)];
}

//通过id从所属行业列表晒出IndexArray
- (NSArray *)professIndexArrayWithId:(NSString *)Id
{
    for (int i = 0; i < self.professionArray.count; i++)
    {
        ProfessionModel *professModel = _professionArray[i];
        NSArray *professArray = professModel.list;
        for (int j = 0; j < professArray.count; j++)
        {
            ProfessionModel *subModel = professArray[j];
            if ([subModel.ID integerValue] == [Id integerValue]) {
                return @[@(i), @(j)];
            }
        }
    }
    
    return @[];
}

//刷新数据源和表
- (void)updateDataAndTableView
{
    NSArray *listArray = @[[NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"婚姻状况"), @"text":[self marriageFormatWithId:_userModel.uMarriage]}], [NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"月收入"), @"text":[self incomeFormatWithId:_userModel.uMonthpay]}], [NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"教育程度"), @"text":[self educatFormatWithId:_userModel.uEducation]}], [NSMutableDictionary dictionaryWithDictionary:@{@"title":String(@"所属行业"), @"text":[self professFormatWithId:_userModel.uProfession]}]];
    [self.listArray removeAllObjects];
    [self.listArray addObjectsFromArray:listArray];
    [_tableView reloadData];
}

#pragma mark - handle action


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person_TFCell *tfCell = [tableView dequeueReusableCellWithIdentifier:[Person_TFCell className] forIndexPath:indexPath];
    tfCell.rightTF.userInteractionEnabled = NO;
    NSDictionary *dic = _listArray[indexPath.section];
    [tfCell configTitle:dic[@"title"] tfText:dic[@"text"]];
    return tfCell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    switch (section)
    {
        case 0:
        {
            QBPickerView *qbPickerView = [[QBPickerView alloc] initWithStyle:QBPickerViewTypeHaveBtn dataArray:@[@"未婚", @"已婚"] columnCount:1 action:^(NSArray *selectedArray) {
    
                NSString *marriage = selectedArray[0];
                if ([marriage isEqualToString:@"未婚"]) {
                    _userModel.uMarriage = @"1";
                } else {
                    _userModel.uMarriage = @"2";
                }
                [self updateDataAndTableView];
            }];
            [qbPickerView selectIndexArray:@[@([_userModel.uMarriage integerValue] - 1)]];
            [qbPickerView show];
            
            break;
        }
        case 1:
        {
            [self requestIncomeList];   //请求收入列表
            break;
        }
        case 2:
        {
            [self requestEducatList];   //请求教育程度列表数据
            break;
        }
            
        default:
        {
            [self requestProfessionList];//请求职业列表数据
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kBottomH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
