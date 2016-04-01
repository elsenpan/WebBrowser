//
//  WebViewController.h
//  WebBrowser
//
//  Created by panelsen on 16/3/31.
//  Copyright © 2016年 panelsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnStop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnRefresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnForward;
@property (assign, nonatomic) BOOL setSessionStorage;
@property (nonatomic ,copy)NSString *currentBaseUrlStr;
- (void)loadRequestFromString:(NSString*)urlString;
- (void)updateButtons;

@end
