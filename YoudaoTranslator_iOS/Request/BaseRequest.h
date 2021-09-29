//
//  BaseRequest.h
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseRequest : YTKRequest

typedef void(^RequestToolsSuccessBlock)(__kindof BaseRequest *request, id result);
typedef void(^RequestToolsFailureBlock)(__kindof BaseRequest *request);

@property(nonatomic, strong) NSString * requestUrl;
 
@property(nonatomic, strong) id requestArgument;
 
@property(nonatomic, strong) NSString * errorInfo;

@property(nonatomic, assign) YTKRequestSerializerType requestSerializerType;
 
- (void)startWithCompletionBlockWithSuccess:(nullable RequestToolsSuccessBlock)success
                                    failure:(nullable RequestToolsFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
