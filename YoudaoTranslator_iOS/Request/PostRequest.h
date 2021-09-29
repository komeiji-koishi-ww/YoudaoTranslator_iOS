//
//  PostRequest.h
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostRequest : BaseRequest

- (instancetype)initWithUrl:(NSString *)url param:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
