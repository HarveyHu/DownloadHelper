//
//  URLDownloadHelper.m
//  VideoPlayback
//
//  Created by HarveyHu on 13/6/10.
//  Licensed under the MIT license
//

#import "URLDownloadHelper.h"

@interface URLDownloadHelper()
@property (retain,nonatomic) NSString* filePath;
@property (retain,nonatomic) NSString* fileName;
- (BOOL)_isFileExistingInDocumentFolder:(NSString*)name;
- (void)_callback;
@end

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
    return _isFinishedFlag;
}

- (NSString*)getFilePath{
    return _filePath;
}

- (NSString*)getFileName{
    return _fileName;
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
    _isFinishedFlag = NO;
    NSString *urlAsString = targetURL;
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //從網址取得檔案名稱
    NSString* tempString = [self stringByReversed:targetURL];
    NSRange search = [tempString rangeOfString:@"/"];
    NSLog(@"%i", search.location);
    _fileName =[self stringByReversed:[tempString substringToIndex:search.location]];
    NSLog(@"%@",_fileName);
    
    
    if (![self _isFileExistingInDocumentFolder:_fileName])
    {
        NSLog(@"檔案不存在本機,開始下載");
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *responce, NSData *data, NSError *error) {
            if ([data length] > 0 && error == nil) {
                NSLog(@"writeToFile:%@",_filePath);
                //將資料寫入檔案
                [data writeToFile:_filePath atomically:YES];
                
                NSLog(@"成功存檔至%@",_filePath);
                _isFinishedFlag = YES;
                [self _callback];
            }
        }];
    }else{
        NSLog(@"檔案已存在本機,不用下載");
        _isFinishedFlag = YES;
    }
}

- (BOOL) _isFileExistingInDocumentFolder:(NSString*)name{
    NSString* documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整檔案路徑
    //filePath = [[NSString alloc]initWithString:[documentsDir stringByAppendingString:name]];
    _filePath = [documentsDir stringByAppendingString:[NSString stringWithFormat: @"%@",name]];
    [_filePath retain];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:_filePath])
    {
        NSLog(@"%@檔案存在",_filePath);
        return YES;
    }else{
        NSLog(@"%@檔案不存在",_filePath);
        return NO;
    }
}

//讓delegate去執行
-(void) _callback{
    [_delegate downloadFinishedWithFilePath:_filePath];
}

-(void)dealloc{
    [_fileName release];
    [_filePath release];
    [super dealloc];
}

@end
