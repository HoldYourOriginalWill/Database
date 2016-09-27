//
//  DataBaseManager.m
//  Database
//
//  Created by mac48 on 16/7/23.
//  Copyright © 2016年 XSj. All rights reserved.
//

#import "DataBaseManager.h"
#import <sqlite3.h>

@implementation DataBaseManager
+ (instancetype)shareManager{
    static DataBaseManager *sharesManger = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharesManger = [[self alloc] init];
        
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/sqlite3.sqlite"];
        NSFileManager *manager = [NSFileManager defaultManager];
        NSLog(@"%@", path);
        
        if ([manager fileExistsAtPath:path]) {
            NSLog(@"文件已存在");
        }else{
        [manager createFileAtPath:path contents:nil attributes:nil];
        
        sqlite3 *sql = nil;
        int sqlDb = sqlite3_open([path UTF8String], &sql);
        if (sqlDb != SQLITE_OK) {
            NSLog(@"创建表单数据库打开失败");
            return;
        }else{
            NSString *string = @"CREATE TABLE User(username TEXT,password TEXT,age Integer);";
            char *error = nil;
            int result = sqlite3_exec(sql, [string UTF8String], nil, nil, &error);
            if (result != SQLITE_OK) {
                NSLog(@"创建表单失败");
                sqlite3_close(sql);
                return;
            }
            NSLog(@"表单创建成功");
            sqlite3_close(sql);
        }
        }
        
    });
    return sharesManger;
}
//添加用户数据
- (BOOL)addUser:(User *)user{
    sqlite3 *sql = nil;
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/sqlite3.sqlite"];
    int sqlDb = sqlite3_open([path UTF8String], &sql);
    if (sqlDb != SQLITE_OK) {
        NSLog(@"添加数据数据库打开失败");
        return 0;
    }else{
        NSString *string = @"INSERT INTO User(username,password,age)VALUES(?,?,?)";
        sqlite3_stmt *stmt = nil;
        int result = sqlite3_prepare_v2(sql, [string UTF8String], -1, &stmt, nil);
        if (result != SQLITE_OK) {
            NSLog(@"添加准备失败");
            sqlite3_close(sql);
            return 0;
        }else{
            sqlite3_bind_text(stmt, 1, [user.username UTF8String], -1, nil);
            sqlite3_bind_text(stmt, 2, [user.password UTF8String], -1, nil);
            sqlite3_bind_int(stmt, 3, (int)user.age);
            result = sqlite3_step(stmt);
            if (result != SQLITE_DONE) {
                NSLog(@"数据添加失败");
                sqlite3_close(sql);
                return 0;
            }
            NSLog(@"数据添加成功");
            sqlite3_finalize(stmt);
            sqlite3_close(sql);
        }
        
    }
    return YES;
}
//修改用户数据
- (BOOL)updateUser:(User *)user{
    
    return YES;
}
////删除用户
//- (BOOL)deleteUser:(User *)user;



//查找用户，使用用户名作为参数
- (User *)searchUser:(NSString *)username{
    User *user = [[User alloc] init];
    sqlite3 *sql = nil;
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/sqlite3.sqlite"];
    int sqlDb = sqlite3_open([path UTF8String], &sql);
    if (sqlDb != SQLITE_OK) {
        NSLog(@"查找用户数据库打开失败");
        return 0;
    }else{
        NSString *string = [NSString stringWithFormat:@"SELECT * FROM User WHERE username = '%@';", username];
        sqlite3_stmt *stmt = nil;
        int result = sqlite3_prepare_v2(sql, [string UTF8String], -1, &stmt, nil);
        if (result != SQLITE_OK) {
            NSLog(@"查找用户准备失败");
            sqlite3_close(sql);
            return 0;
        }else{
            result = sqlite3_step(stmt);
            while(result == SQLITE_ROW) {
                char *username = (char *)sqlite3_column_text(stmt, 0);
                char *password = (char *)sqlite3_column_text(stmt, 1);
                int age = sqlite3_column_int(stmt, 2);
                user.username = [NSString stringWithFormat:@"%s", username];
                user.password = [NSString stringWithFormat:@"%s", password];
                user.age = age;
                result = sqlite3_step(stmt);
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(sql);
    }
    return user;
}
////查找某一年龄段段用户
//- (NSArray *)searchuserFromAge:(NSUInteger)fAge toAge:(NSUInteger)tAge;
//查找所有用户
- (NSArray *)allUsers{
    NSMutableArray *userArr = [[NSMutableArray alloc] initWithCapacity:0];
    sqlite3 *sql = nil;
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/sqlite3.sqlite"];
    int sqlDb = sqlite3_open([path UTF8String], &sql);
    if (sqlDb != SQLITE_OK) {
        NSLog(@"查找用户数据库打开失败");
        return 0;
    }else{
        NSString *string = @"SELECT * FROM User;";
        sqlite3_stmt *stmt = nil;
        int result = sqlite3_prepare_v2(sql, [string UTF8String], -1, &stmt, nil);
        if (result != SQLITE_OK) {
            NSLog(@"查找用户准备失败");
            sqlite3_close(sql);
            return 0;
        }else{
            result = sqlite3_step(stmt);
            while(result == SQLITE_ROW) {
                User *user = [[User alloc] init];
                char *username = (char *)sqlite3_column_text(stmt, 0);
                char *password = (char *)sqlite3_column_text(stmt, 1);
                int age = sqlite3_column_int(stmt, 2);
                user.username = [NSString stringWithFormat:@"%s", username];
                user.password = [NSString stringWithFormat:@"%s", password];
                user.age = age;
                //NSLog(@"%@", user);
                [userArr addObject:user];
                result = sqlite3_step(stmt);
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(sql);
    }
    return userArr;
}
//查找用户总数
//- (NSUInteger)userCount;

//登陆操作
- (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password{
    return YES;
}
@end
