//
//  URLDownloadHelper.h
//  VideoPlayback
//
//  Created by HarveyHu on 13/6/10.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface URLDownloadHelper : NSObject<NSURLConnectionDownloadDelegate>{
    NSURLConnection* connetction;
}

+(URLDownloadHelper*)initWithSingletonMode;
- (void)downloadWithUrl:(NSString*)targetURL;
@end
