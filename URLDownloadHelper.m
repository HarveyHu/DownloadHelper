//
//  URLDownloadHelper.m
//  VideoPlayback
//
//  Licensed under the MIT license
//  Created by HarveyHu on 13/6/10.
//
//

#import "URLDownloadHelper.h"


@implementation URLDownloadHelper

//implement singleton pattern
+(URLDownloadHelper*)initWithSingletonMode{
    static URLDownloadHelper* singleton;
    
    if (!singleton) {
        singleton = [[URLDownloadHelper alloc]init];
    }
    
    return singleton;
}

#pragma mark - implement download delegate

- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes
{
    //float percent = (float) totalBytesWritten / (float) expectedTotalBytes;
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^(){
        //如果要用UIKit的畫面，要回main theard去呼叫
    }];
}

- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL
{
    if (!destinationURL)
    {
        NSLog(@"Fail to download.");
        return;
    }
    
    NSLog(@"File downloaded to temp Folder: %@", destinationURL);
}

- (void)downloadWithUrl:(NSString*)targetURL
{
    
    
    NSURL *url = [NSURL URLWithString:targetURL];
    //設定網站連線時間上限，以及cache方式（這裡是會先用cache檔，如果沒有再從網址去下載）
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20.f];
    connetction = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [request release];
}

@end
