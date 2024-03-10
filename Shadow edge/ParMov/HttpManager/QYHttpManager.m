//
//  QYHttpManager.m
//  SimilarSamer
//
//  Created by Hz-Pro on 2020/8/13.
//  Copyright © 2020 QY. All rights reserved.
//

#import "QYHttpManager.h"
#import <MJExtension/MJExtension.h>
static NetworkStatus _status;
static QYHttpManager *QYHttpSessionManager = nil;
@implementation QYHttpManager

#pragma mark - 实现声明单例方法 GCD
+ (QYHttpManager *)sharedInstance {
    static dispatch_once_t demoglobalclassonce;
    dispatch_once(&demoglobalclassonce, ^{
        QYHttpSessionManager = [[QYHttpManager alloc] init];
    });
    return QYHttpSessionManager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        QYHttpSessionManager = [super allocWithZone:zone];
    });
    return QYHttpSessionManager;
}
+ (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        QYHttpSessionManager = [super init];
        [self startMonitoringNetwork];
    });
    return QYHttpSessionManager;
}

#pragma mark - 设置AFHTTPSessionManager相关属性
+ (AFHTTPSessionManager *)createAFHTTPSessionManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        manager = [AFHTTPSessionManager manager];
        //设置请求参数的类型:json (AFJSONRequestSerializer,AFHTTPRequestSerializer)
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //设置请求的超时时间
        manager.requestSerializer.timeoutInterval = 10.0f;
        //请求头类型
        [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        //添加状态改变通知
        //[[self sharedInstance].requestSerializer willChangeValueForKey:@"timeoutInterval"];
        //[[self sharedInstance].requestSerializer didChangeValueForKey:@"timeoutInterval"];
        /*! 打开状态栏的等待菊花 */
        //根据服务器的设定不同还可以设置：json：[AFJSONResponseSerializer serializer](常用)http：[AFHTTPResponseSerializer serializer]
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 设置响应数据的基本类型
        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain",@"application/x-javascript",@"image/png",@"text/html",@"application/x-javascript",@"application/javascript", @"json/text", nil];
        //https参数配置  采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = NO;
        //可能会对http请求影响
        //securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
    });
    return manager;
}

+(void)requestPostMd5WithUrl:(NSString *)url param:(NSDictionary *)param progress:(HttpProgress)progress success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *requestUrl =  [NSString stringWithFormat:@"https://www.hbjyapp.com/toboring/app/api%@",url];
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    [[manager POST:requestUrl parameters:param headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:[@"Data" dataUsingEncoding:NSUTF8StringEncoding]
                name:@"DataName"
            fileName:@"DataFileName"
            mimeType:@"data"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            progress ? progress(uploadProgress) : nil;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
     
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
           
        }] resume];
    
    
}

#pragma mark
+(void)requestPostWithUrl:(NSString *)url param:(NSDictionary *)param progress:(HttpProgress)progress success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString* jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:param options:0 error:nil] encoding:NSUTF8StringEncoding];


    AFHTTPSessionManager *  manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"image/png",nil];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    AFJSONResponseSerializer *reponse = [AFJSONResponseSerializer serializer];

    reponse.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"image/png", nil];

    reponse.removesKeysWithNullValues = YES;

    manager.responseSerializer = reponse;


    NSString *requestUrl =  [NSString stringWithFormat:@"%@%@",@"https://www.hbjyapp.com/toboring/app/api",url];
    
    
    
    [[manager POST:requestUrl parameters:jsonStr headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            progress ? progress(uploadProgress) : nil;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
            
        }] resume] ;

}

#pragma mark 上传图片
+ (void)requestUploadImageWithUrl:(NSString *)url
                            param:(NSDictionary *)param
                        imageData:(NSData *)imageData
                         progress:(HttpProgress)progress
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailed)failure {
    NSString * requestUrl = [NSString stringWithFormat:@"%@%@",@"https://www.hbjyapp.com/toboring/app/api",url];
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    [[manager POST:requestUrl parameters:param headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.png" mimeType:@"image/jpeg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            progress ? progress(uploadProgress) : nil;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        
        }] resume];
}


#pragma mark - 开始监听网络
+ (void)startMonitoringNetwork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                _status(QYNetworkStatusUnknown);
//                QLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _status(QYNetworkStatusNotReachable);
//                QLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _status(QYNetworkStatusReachableViaWWAN);
//                QLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _status(QYNetworkStatusReachableViaWiFi);
//                QLog(@"WIFI");
                break;
        }
    }];
    [manager startMonitoring];
    
}
+ (void)networkStatusWithBlock:(NetworkStatus)status
{
    _status = status;
}
//通用post[参数为json数据结构]
+ (void)postWithUrl:(NSString *)URLString jsonParameters:(id)parameters progressShow:(BOOL)show success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    id params = nil;
    if([parameters isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
        params = (NSMutableDictionary *)[param mj_keyValues];
    } else {
        params = [parameters mj_keyValues];
    }

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", @"multipart/form-data"]];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 15;

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"https://www.hbjyapp.com/app/api/%@", URLString] parameters:nil error:nil];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //自定义header参数
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    [request setValue:app_Version forHTTPHeaderField:@"version"];
//    [request setValue:@"ios" forHTTPHeaderField:@"platform"];
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = nil;
    jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSData *body = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:body];
    NSLog(@"request %@",request.allHTTPHeaderFields);

    [[session dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {

        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {

        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            NSLog(@"请求成功---%@---%@",responseObject, [responseObject class]);
        
            if(responseObject && [responseObject[@"code"] integerValue] == 200) {
                success(responseObject);
            } else {
                NSLog(@"%@",URLString);


            }
        }] resume];
}


+ (void)downloadFileWithURL:(NSString *)partUrl data:(NSData *)data  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
//    [SVProgressHUD showWithStatus:@"加载中, 请稍候..."];

}


@end
