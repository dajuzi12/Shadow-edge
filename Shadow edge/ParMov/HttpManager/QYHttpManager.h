//
//  QYHttpManager.h
//  SimilarSamer
//
//  Created by Hz-Pro on 2020/8/13.
//  Copyright © 2020 QY. All rights reserved.
//

#import <AFNetworking.h>
#import "ResponseObject.h"
//#import <QCloudCOSXML/QCloudCOSXML.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QYNetworkStatus) {
    /** 未知网络*/
    QYNetworkStatusUnknown,
    /** 无网络*/
    QYNetworkStatusNotReachable,
    /** 手机网络*/
    QYNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    QYNetworkStatusReachableViaWiFi
};
/** 网络状态的Block*/
typedef void(^NetworkStatus)(QYNetworkStatus status);

/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(ResponseObject *responseObject);

/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSDictionary *errorDict);

/** 缓存的Block */
typedef void(^HttpRequestCache)(ResponseObject *responseCache);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^HttpProgress)(NSProgress *progress);

@interface QYHttpManager : NSObject


+ (void)networkStatusWithBlock:(NetworkStatus)status;

#pragma mark 不包含TokenPOST请求
+(void)requestPostWithUrl:(NSString *)url
                           param:(NSDictionary *)param
                        progress:(_Nullable HttpProgress)progress
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailed)failure;
#pragma mark上传图片
+ (void)requestUploadImageWithUrl:(NSString *)url
                            param:(NSDictionary *)param
                        imageData:(NSData *)imageData
                         progress:(_Nullable HttpProgress)progress
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailed)failure;
#pragma mark
+(void)requestPostMd5WithUrl:(NSString *)url
                       param:(NSDictionary *)param
                    progress:(HttpProgress)progress
                     success:(HttpRequestSuccess)success
                     failure:(HttpRequestFailed)failure;


/**
 * 发送POST请求(参数为json结构数据)
 * urlString   请求的基本的url
 * parameters  请求的参数字典
 * show        是否显示Loading框(YES or NO)
 * success     请求成功的回调
 * failure     请求失败的回调
 */
+ (void)postWithUrl:(NSString *)URLString
     jsonParameters:(id)parameters
       progressShow:(BOOL)show
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;



/**
 * 上传文件(文件[图片、视频、文件]参数)
 * partUrl   请求的文件key值l
 * data       文件[图片、视频、文件]数据
 * type      文件类型(音频、视频或其他文件)
 * success     请求成功的回调
 * failure     请求失败的回调
 */
//+ (void)uploadFileWithURL:(NSString *)partUrl data:(NSData *)data  success:(void (^)(QCloudUploadObjectResult *responseObject))success failure:(void (^)(NSError *error))failure;


/**
 * 下载文件(文件[图片、视频、文件]参数)
 * partUrl   请求的文件key值l
 * data       文件[图片、视频、文件]数据
 * type      文件类型(音频、视频或其他文件)
 * success     请求成功的回调
 * failure     请求失败的回调
 */
+ (void)downloadFileWithURL:(NSString *)partUrl data:(NSData *)data  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
