//
//  URLDownloadHelper.h
//  VideoPlayback
//
//  Created by HarveyHu on 13/6/10.
//  Licensed under the MIT license
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//宣告protocal
@protocol URLDownloadHelperDelegate <NSObject>
@optional
- (void)downloadFinishedWithFilePath:(NSString*)filePath;
@end

@interface URLDownloadHelper : NSObject{
    BOOL _isFinishedFlag;
    
}

@property (nonatomic, assign) id<URLDownloadHelperDelegate> delegate;



+(URLDownloadHelper*)sharedInstance;
- (void) downloadWithUrl:(NSString*)targetURL;
- (BOOL) isFinished;
- (NSString*) getFilePath;
- (NSString*) getFileName;
@end