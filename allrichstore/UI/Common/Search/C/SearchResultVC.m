//
//  SearchResultVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SearchResultVC.h"  //搜索结果列表控制器
#import "SearchVC.h"
#import "GoodsModel.h"

@interface SearchResultVC ()<UITextFieldDelegate>

@end

@implementation SearchResultVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
    //中间的搜索栏
    UITextField *searchTF = [[UITextField alloc] init];
    [searchTF setBackground:[[UIImage imageWithColor:QFColor_SearchBarBg size:CGSizeMake(100, 30)]roundedCornerImage:5 borderSize:0]];
    searchTF.delegate = self;
    searchTF.layer.masksToBounds = YES;
    searchTF.layer.cornerRadius = 5.0;
    searchTF.backgroundColor = QFColor_SearchBarBg;
    searchTF.bounds = CGRectMake(0, 0, kScreenW, 30);
    searchTF.font = Font(14);
    searchTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索宝贝" attributes:@{NSForegroundColorAttributeName: kGrayColor}];
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    
    searchTF.text = self.searchText;
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 40, 30);
    [leftBtn setImage:Image(@"sousuokuang_fangdajing") forState:UIControlStateNormal];
    leftBtn.userInteractionEnabled = NO;
    searchTF.leftView = leftBtn;
    
    self.searchTF = searchTF;
    
    self.navigationItem.titleView = _searchTF;
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
    
}

//重写滞空 （为了不添加搜索按钮）
- (void)addSearchBtn
{
    
}

#pragma mark - setter
- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    _searchTF.text = _searchText;
    [self.refreshHeader beginRefreshing];
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"name":_searchText};
    WS(weakSelf)
    [self POST:API_SearchGoods parameters:parameters success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        [self.listArray removeAllObjects];
        [self.listArray addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:array]];
        [weakSelf.collectionView reloadData];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SearchVC *searchVC = [SearchVC new];
    searchVC.searchResultVC = self;
    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:searchVC];
    [self presentVC:nc animated:NO completion:nil];
    return NO;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
