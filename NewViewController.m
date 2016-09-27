//
//  NewViewController.m
//  Database
//
//  Created by mac48 on 16/7/23.
//  Copyright © 2016年 XSj. All rights reserved.
//

#import "NewViewController.h"
#import "DataBaseManager.h"
@interface NewViewController ()
@property (weak, nonatomic) IBOutlet UITextField *IDTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}
- (void)createView{
    self.title = @"新建用户";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.view.backgroundColor = [UIColor cyanColor];
}
- (void)complete{
    DataBaseManager *manager = [DataBaseManager shareManager];
    User *user = [[User alloc] init];
    user.username = _IDTextField.text;
    user.password = _passwordTextField.text;
    user.age = [_ageTextField.text integerValue];
    [manager addUser:user];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
