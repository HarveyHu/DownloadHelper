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
static URLDownloadHelper* instance = nil;
+(URLDownloadHelper*)sharedInstance{
    @synchronized(self){
        
        if (instance == nil) {
            instance = [[URLDownloadHelper alloc]init];
        }
    }
    return instance;
}

-(BOOL)isFinished{
    return isFinishedFlag;
}

- (NSString*)getFilePath{
    return filePath;
}

//文字反轉
-(NSString *)stringByReversed:(NSString*)sourceString{
    NSUInteger i = 0;
    NSUInteger j = sourceString.length - 1;
    unichar characters[sourceString.length];
    while (i < j) {
        characters[j] = [sourceString characterAtIndex:i];
        characters[i] = [sourceString characterAtIndex:j];
        i ++;
        j --;
    }
    if(i == j)
        characters[i] = [sourceString characterAtIndex:i];
    return [NSString stringWithCharacters:characters length:sourceString.length];
}

//下載影片後reload
- (void)downloadWithUrl:(NSString*)targetURL
{
   
    isFinishedFlag = NO;
    NSString *urlAsString = targetURL;
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //從網址取得檔案名稱
    NSString* tempString = [self stringByReversed:targetURL];
    NSRange search = [tempString rangeOfString:@"/"];
    NSLog(@"%i", search.location);
    NSString* fileName =[self stringByReversed:[tempString substringToIndex:search.location]];
    NSLog(@"%@",fileName);
    
    
    if (![self isFileExistingInDocumentFolder:fileName])
    {
        NSLog(@"檔案不存在本機,開始下載");
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *responce, NSData *data, NSError *error) {
            if ([data length] > 0 && error == nil) {
                
                //將資料寫入檔案
                [data writeToFile:filePath atomically:YES];
                
                NSLog(@"成功存檔至%@",filePath);
                isFinishedFlag = YES;
                [self callback];
            }
        }];
    }else{
        NSLog(@"檔案已存在本機,不用下載");
        isFinishedFlag = YES;
    }
}

- (BOOL) isFileExistingInDocumentFolder:(NSString*)fileName{
    NSString* documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整檔案路徑
    filePath = [documentsDir stringByAppendingString:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"%@檔案存在",fileName);
        return YES;
    }else{
        NSLog(@"%@檔案不存在",fileName);
        return NO;
    }
}
//讓delegate去執行
-(void) callback{
    [_delegate downloadFinishedWithFilePath:filePath];
}
@end
