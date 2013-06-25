//
//  URLDownloadHelper.h
//  VideoPlayback
//
//  Licensed under the MIT license
//  Created by HarveyHu on 13/6/10.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface URLDownloadHelper : NSObject<NSURLConnectionDownloadDelegate>{
    
}

+(URLDownloadHelper*)initWithSingletonMode;
- (void)downloadWithUrl:(NSString*)targetURL;
@end
