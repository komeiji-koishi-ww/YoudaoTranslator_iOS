//
//  PostRequest.m
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

#import "PostRequest.h"

@implementation PostRequest

//- (instancetype)initWithUrl:()

- (instancetype)initWithUrl:(NSString *)url param:(NSDictionary *)param {
    
    self = [super init];
    if (self){
        self.requestUrl = url;
        
        NSMutableDictionary * mParam = [param mutableCopy];
        
        self.requestArgument = mParam;
    }
    
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    
    return @{
            @"User-Agen" : @"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36 Edg/94.0.992.31",
            @"Referer": @"http://fanyi.youdao.com/",
            @"Cookie": @"OUTFOX_SEARCH_USER_ID=\"-1848382357@10.169.0.84\"; ___rl__test__cookies=1625907853887; OUTFOX_SEARCH_USER_ID_NCOO=132978720.55854891",
            @"X-Requested-With": @"XMLHttpRequest"

    };

}

@end
