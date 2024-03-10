//
//  GXBaseModel.h
//  Laite
//
//  Created by TimorYang on 2020/7/28.
//  Copyright © 2020 Gx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResponseObject : NSObject

/// 接口状态码:  0 是正常
@property (nonatomic, assign) int code;
/// 接口状态信息
@property (nonatomic, copy) NSString *msg;
/// 接口错误信息
@property (nonatomic, strong) NSString *time;
/// 接口数据
@property (nonatomic, strong) id data;

@end

NS_ASSUME_NONNULL_END
