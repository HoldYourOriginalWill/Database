//
//  UserViewController.m
//  Database
//
//  Created by mac48 on 16/7/23.
//  Copyright © 2016年 XSj. All rights reserved.
//

#import "UserViewController.h"
#import "NewViewController.h"
#import "LoginViewController.h"
#import "DataBaseManager.h"
@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *dataTableView;
    DataBaseManager *manager;
    NSArray *arr;
}
@end

@implementation UserViewController
-(void)viewDidAppear:(BOOL)animated{
    if (arr == nil) {
        arr = [[NSArray alloc] init];
        manager = [DataBaseManager shareManager];
    }
    arr = [manager allUsers];
    [dataTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor cyanColor];
    
    [self createNavView];
    [self createTableview];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)createNavView{
    self.title = @"用户列表";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)createTableview{
    dataTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    dataTableView.delegate = self;
    dataTableView.dataSource = self;
    [self.view addSubview:dataTableView];
}

- (void)newAction{
    NewViewController *new = [[NewViewController alloc] init];
    [self.navigationController pushViewController:new animated:YES];
}
- (void)logIn{
    LoginViewController *logIn = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:logIn animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%li", arr.count);
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    User *user = arr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@               年龄：%li", user.username, user.age];
        return cell;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellID = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    cell.textLabel.text = @"aa";
//    return cell;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
