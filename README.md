DownloadHelper
==============
project: DownloaderHelper<br/>
Author: Harvey Hu<br/>
URL: https://github.com/HarveyHu/DownloadHelper<br/>
License: the MIT license.<br/>

##About DownloadHelper<br/>
Objective-C class to download a file to temp folder in your App's sandbox.<br/><br/>

You should import URLDownloadHelper.h to your project.<br/>
To download a file from the internet to your sandbox of your App by the following code:<br/>

URLDownloadHelper* downloader = [[URLDownloadHelper alloc] initWithSingleMode];<br/>
[downloader downloadWithUrl: #YourTargetURL];<br/><br/>

##Info
DownloadHelper supports iOS 5.0 to 6.x.
