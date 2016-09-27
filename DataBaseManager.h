//
//  DataBaseManager.h
//  02 SQLite in iOS
//
//  Created by ZhuJiaCong on 16/5/3.
//  Copyright © 2016年 ZhuJiaCong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@class User;

@interface DataBaseManager : NSObject


+ (instancetype)shareManager;


//添加用户数据
- (BOOL)addUser:(User *)user;
//修改用户数据
- (BOOL)updateUser:(User *)user;
////删除用户
//- (BOOL)deleteUser:(User *)user;



//查找用户，使用用户名作为参数
- (User *)searchUser:(NSString *)username;
////查找某一年龄段段用户
//- (NSArray *)searchuserFromAge:(NSUInteger)fAge toAge:(NSUInteger)tAge;
//查找所有用户
- (NSArray *)allUsers;


//查找用户总数
//- (NSUInteger)userCount;

//登陆操作
- (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password;



@end