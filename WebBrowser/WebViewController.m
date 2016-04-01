//
//  WebViewController.m
//  WebBrowser
//
//  Created by panelsen on 16/3/31.
//  Copyright © 2016年 panelsen. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _currentBaseUrlStr = @"about:blank";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
//    self.webView.scalesPageToFit= YES;
    // This is a hack which listens to a private notification
    // see http://stackoverflow.com/questions/18948373/why-is-uiwebview-cangoback-no-in-ios7
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateButtons)
                                                 name:@"WebHistoryItemChangedNotification"
                                               object:nil];
    [self loadRequestFromString:_currentBaseUrlStr];
}

- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - webView delegate
#pragma mark -
- (void)webView:(UIWebView *)web didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
    
	if (error.code == NSURLErrorCancelled) return;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
}

- (BOOL)webView:(UIWebView *)web shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    if ([urlStr hasSuffix:@"/"]) {
        urlStr = [urlStr substringToIndex:urlStr.length - 1];
    }
    if ([urlStr isEqualToString:@"about:blank"]) {
        return NO;
    }
    if ([urlStr hasPrefix:@"tel:"]||[urlStr hasPrefix:@"msm:"]) {
        return YES;
    }
    
    if (urlStr.length >= self.currentBaseUrlStr.length) {
        NSString * mach_urlStr =  [urlStr substringToIndex:self.currentBaseUrlStr.length ];
        if ([mach_urlStr isEqualToString:self.currentBaseUrlStr]) {
            [self updateButtons];
            return YES;
        }
    }
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)web
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!self.setSessionStorage) {
        self.setSessionStorage = YES;
        NSDictionary *property = [NSDictionary dictionaryWithObjectsAndKeys:@100004,@"id", @"158*****767",@"login",@"VMy5cntom1xUkVo_rQRVaA",@"token", nil];
        NSError * error;
        NSData * data =  [NSJSONSerialization dataWithJSONObject:property options:0  error:&error];
        NSString * jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *js = [NSString stringWithFormat:@"sessionStorage.setItem('user', '%@');",jsonString];
        [webView stringByEvaluatingJavaScriptFromString:js];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}
- (void)updateButtons
{
    self.btnForward.enabled = self.webView.canGoForward;
    self.btnBack.enabled = self.webView.canGoBack;
    self.btnStop.enabled = self.webView.loading;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
