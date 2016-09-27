//
//  User.h
//  02 SQLite in iOS
//
//  Created by ZhuJiaCong on 16/5/3.
//  Copyright © 2016年 ZhuJiaCong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) NSUInteger age;

@end
