//
//  LoginViewController.m
//  Database
//
//  Created by mac48 on 16/7/23.
//  Copyright © 2016年 XSj. All rights reserved.
//

#import "LoginViewController.h"
#import "DataBaseManager.h"
#import "User.h"
@interface LoginViewController ()
{
    DataBaseManager *manager;
}
@property (weak, nonatomic) IBOutlet UITextField *IDTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
    self.view.backgroundColor = [UIColor yellowColor];
    manager  = [DataBaseManager shareManager];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)logIn:(id)sender {
    User *user = [[User alloc] init];
    user = [manager searchUser:_IDTextField.text];
    //NSLog(@"%@,%@",user.password,_passwordTextField.text);
    if (user.password == _passwordTextField.text) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登陆成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号或密码错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
