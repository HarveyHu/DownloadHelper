DownloadHelper
==============
project: DownloaderHelper
Author: Harvey Hu
URL: https://github.com/HarveyHu/DownloadHelper
License: the MIT license.


Objective-C class to download a file to temp folder in your App's sandbox.

You should import URLDownloadHelper.h to your project.
To download a file from the internet to your sandbox of your App by the following code:

URLDownloadHelper* downloader = [[URLDownloadHelper alloc] initWithSingleMode];
[downloader downloadWithUrl: #YourTargetURL];

PS.This class can only valid under iOS 5.0 and higher.
