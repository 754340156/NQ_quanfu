//
//  SearchVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SearchVC.h"        //搜索控制器
#import "SearchMatchCell.h" //搜索匹配cell
#import "HomeVC.h"          //首页

#import "SearchResultVC.h"  //搜索结果列表控制器

@interface SearchVC ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *resultArray;  //装载匹配结果的数组

@end

static NSString *identifierCell = @"SearchMatchCell";

@implementation SearchVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
}

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
    //从沙盒取历史搜索记录
    NSArray *searchArray = [Tools readFromSandBox:SearchArrayKey];
    [self.listArray addObjectsFromArray:searchArray];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
    self.navigationItem.titleView = self.searchBar;
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    //添加tableView
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SearchMatchCell class] forCellReuseIdentifier:identifierCell];
    
    //设置表头
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 32)];
    headerView.backgroundColor = kWhiteColor;
    [headerView addBottomLineWithHeight:0.7];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(Adapted(12), 0, 200, headerView.height)];
    headerLabel.font = BoldFont(15);
    headerLabel.textColor = QF_BlackColor;
    headerLabel.text = @"历史搜索";
    [headerView addSubview:headerLabel];
    _tableView.tableHeaderView = headerView;
    
    if (_listArray.count == 0)
    {
        return;
    }
    
    //设置表脚（清空历史记录）
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 90)];
    footerView.backgroundColor = kWhiteColor;
    
    UIButton *cleanRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanRecordBtn.frame = CGRectMake(Adapted(40), 25, _tableView.width - Adapted(40) * 2.0, 40);
    cleanRecordBtn.layer.masksToBounds = YES;
    cleanRecordBtn.layer.cornerRadius = 3.0;
    [cleanRecordBtn.titleLabel setFont:Font(14)];
    [cleanRecordBtn setTitle:@"清空历史搜索" forState:UIControlStateNormal];
    [cleanRecordBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
    [cleanRecordBtn setBackgroundImage:[UIImage imageWithColor:BaseColor_Cell_SelectedBackground] forState:UIControlStateHighlighted];
    cleanRecordBtn.layer.borderWidth = 0.5;
    cleanRecordBtn.layer.borderColor = kGrayColor.CGColor;
    [cleanRecordBtn addTarget:self action:@selector(handleCleanRecord) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:cleanRecordBtn];
    _tableView.tableFooterView = footerView;
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

//重写（父类带动画，本类选择不带动画）
- (void)handleDismiss
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - lazy
- (UISearchBar *)searchBar
{
    if (!_searchBar)
    {
        //中间的搜索栏
        self.searchBar = [[UISearchBar alloc] init];
        _searchBar.showsCancelButton = YES;
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入关键字";
        
        //更改UISearchBar的TextField的属性
        [_searchBar setSearchFieldBackgroundImage:[[UIImage imageWithColor:QFColor_SearchBarBg size:CGSizeMake(100, 30)] roundedCornerImage:5 borderSize:0] forState:UIControlStateNormal];
        
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.layer.masksToBounds = YES;
        searchField.layer.cornerRadius = 5.0;
        searchField.layer.borderWidth = 0.5;
        searchField.layer.borderColor = [UIColor colorWithWhite:0.86 alpha:1.0].CGColor;
        searchField.textColor = QF_BlackColor;
        [searchField setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        
        UIImage *image = Image(@"sousuokuang_fangdajing");
        UIImageView *iconView = [[UIImageView alloc] initWithImage:image];
        iconView.frame = CGRectMake(0, 0, image.size.width , image.size.height);
        searchField.leftView = iconView;
    }
    
    return _searchBar;
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    
}

#pragma mark - custom method
//通过关键字搜索数据
- (void)searchDataWithText:(NSString *)text
{
    //不同插入，相同调到数组最前面
    [_listArray insetFirstEachString:text];
    //更新本地历史搜索记录
    [Tools writeToSandBox:_listArray key:SearchArrayKey];
    
    [self dismissVCAnimated:NO completion:^{
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (!self.searchResultVC)
            {
                SearchResultVC *searchResultVC = [SearchResultVC new];
                self.searchResultVC = searchResultVC;
                [self.frontNC pushVC:searchResultVC animated:YES];
            }
            
            self.searchResultVC.searchText = text;
            
        });
        
    }];
}

#pragma mark - handle action
//清空历史记录
- (void)handleCleanRecord
{
    [UIAlertController qb_showAlertWithTitle:nil message:@"确定清空历史搜索吗？" cancelTitle:@"取消" otherTitles:@[@"确定"] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
        
        [_listArray removeAllObjects];
        [Tools writeToSandBox:_listArray key:SearchArrayKey];
        _tableView.tableFooterView = [UIView new];
        [_tableView reloadData];
        
    } vc:self];
}

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    cell.titleLabel.text = _listArray[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = _listArray[indexPath.row];
    //通过关键字搜索数据
    [self searchDataWithText:text];
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - <UISearchBarDelegate>
//搜索栏 -- 取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissVCAnimated:NO completion:nil];
}

//搜索栏 -- 输入的文字改变时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

//搜索栏 -- 键盘点击搜索时触发
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //通过关键字搜索数据
    [self searchDataWithText:searchBar.text];
}

#pragma mark - <UIScrollViewDelegate>
//UIScrollView滑动 -- 收回键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationController.navigationBar endEditing:YES];
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
