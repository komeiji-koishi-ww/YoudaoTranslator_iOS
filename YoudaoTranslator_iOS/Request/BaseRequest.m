//
//  BaseRequest.m
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

#import "BaseRequest.h"
#import <YYKit.h>

@implementation BaseRequest

- (void)startWithCompletionBlockWithSuccess:(RequestToolsSuccessBlock)success failure:(RequestToolsFailureBlock)failure {
 
    [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
       
        !success ?: success(request, [request responseObject]);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        !failure ?: failure(request);
    }];
    
}

- (YTKResponseSerializerType)responseSerializerType {

    return YTKResponseSerializerTypeJSON;
}

-(NSURLRequest *)currentRequest{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.requestUrl]]];
    
    NSString *contentStr = [self.requestArgument jsonStringEncoded];
    
    NSData *bodyData = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:bodyData];
    return request;
}

@end
