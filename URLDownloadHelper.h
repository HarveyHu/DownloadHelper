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

//宣告protocal
@protocol URLDownloadHelperDelegate <NSObject>
@optional
- (void)downloadFinishedWithFilePath:(NSString*)filePath;
@end

@interface URLDownloadHelper : NSObject{
    BOOL isFinishedFlag;
    NSString* filePath;
}

@property (nonatomic, assign) id<URLDownloadHelperDelegate> delegate;
- (void)callback;

+(URLDownloadHelper*)initWithSingletonMode;
- (void)downloadWithUrl:(NSString*)targetURL;
- (BOOL) isFileExistingInDocumentFolder:(NSString*)fileName;
- (BOOL)isFinished;
- (NSString*)getFilePath;
@end
