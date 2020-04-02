//
//  ViewController.m
//  Testhtml
//
//  Created by 郭超 on 2020/4/2.
//  Copyright © 2020 gucohao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property(nonatomic, strong)UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webview  = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.webview];
    
    [self.webview setDelegate:self];
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"editor.html" withExtension:nil];
   
    NSURLRequest*d = [NSURLRequest requestWithURL:path];
    [self.webview loadRequest:d];
   
 
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *bodyString = @"document.body.outerHTML";
    NSString *body = [webView  stringByEvaluatingJavaScriptFromString:bodyString];
    NSLog(@"%@",body);
    
    NSString *btn = @"var btn = document.getElementById('zss_editor_content');" ;
    [webView  stringByEvaluatingJavaScriptFromString:btn];
    
    /**
     66666666\\n<div>\\n    <div>\\n        < img src=\"https://static.oss.cdn.oss.gaoshier.cn/image/2fc84c57-d62d-4eee-b9ba-e57b37bca341.jpg\">\\n        <div style=\"text-align: center;color: #888;\"></div>\\n        <hr style=\"border: 0;border-top: 0px solid #ccc;margin: 5px 0;\">\\n        <div>\\n            <br />\\n        </div>\\n        <div>7777777</div>\\n    </div>\\n</div>\\n<div>\\n    <div>\\n        < img src=\"https://static.oss.cdn.oss.gaoshier.cn/image/3a2992a6-c8de-49a9-828a-daf50fddd9f6.jpg\">\\n        <div style=\"text-align: center;color: #888;\"></div>\\n        <hr style=\"border: 0;border-top: 0px solid #ccc;margin: 5px 0;\">\\n        <div>888888</div>\\n        <div>\\n            <div>\\n                < img src=\"https://static.oss.cdn.oss.gaoshier.cn/image/f1262ab2-2adc-40a5-a0cd-17a430dbcd4f.jpg\">\\n                <div style=\"text-align: center;color: #888;\"></div>\\n                <hr style=\"border: 0;border-top: 0px solid #ccc;margin: 5px 0;\">\\n                <div>\\n                    <br />\\n                </div>\\n                <div>99999</div>\\n            </div>\\n        </div>\\n        <div>\\n            <div>\\n                < img src=\"https://static.oss.cdn.oss.gaoshier.cn/image/fb5e13a1-05af-4cce-bf2b-8a5067f3b729.jpg\">\\n                <div style=\"text-align: center;color: #888;\"></div>\\n                <hr style=\"border: 0;border-top: 0px solid #ccc;margin: 5px 0;\">\\n                <div>\\n                    <br />\\n                </div>\\n                <div>\\n                    <br />\\n                </div>\\n            </div>\\n        </div>\\n        <div>\\n            <br />\\n        </div>\\n    </div>\\n</div>
     */
    
    NSString *attr = [NSString stringWithFormat:@"btn.innerHTML = '%@';", @"66666666\\n<div>\\n    <div>\\n        <img src=\"https://static.oss.cdn.oss.gaoshier.cn/image/2fc84c57-d62d-4eee-b9ba-e57b37bca341.jpg\">\\n        <div style=\"text-align: center;color: #888;\"></div>\\n        <hr style=\"border: 0;border-top: 0px solid #ccc;margin: 5px 0;\">\\n        <div>\\n            <br />\\n        </div>\\n        <div>7777777</div>\\n    </div>\\n</div>\\n<div>\\n    <div>\\n        <img src=\"https://static.oss.cdn.oss.gaoshier.cn/image/3a2992a6-c8de-49a9-828a-daf50fddd9f6.jpg\">\\n        <div style=\"text-align: center;color: #888;\"></div>\\n        <hr style=\"border: 0;border-top: 0px solid #ccc;margin: 5px 0;\">\\n        <div>888888</div>\\n        <div>\\n            <div>\\n                <img src=\"https://static.oss.cdn.oss.gaoshier.cn/image/f1262ab2-2adc-40a5-a0cd-17a430dbcd4f.jpg\">\\n                <div style=\"text-align: center;color: #888;\"></div>\\n                <hr style=\"border: 0;border-top: 0px solid #ccc;margin: 5px 0;\">\\n                <div>\\n                    <br />\\n                </div>\\n                <div>99999</div>\\n            </div>\\n        </div>\\n        <div>\\n            <div>\\n                <img src=\"https://static.oss.cdn.oss.gaoshier.cn/image/fb5e13a1-05af-4cce-bf2b-8a5067f3b729.jpg\">\\n                <div style=\"text-align: center;color: #888;\"></div>\\n                <hr style=\"border: 0;border-top: 0px solid #ccc;margin: 5px 0;\">\\n                <div>\\n                    <br />\\n                </div>\\n                <div>\\n                    <br />\\n                </div>\\n            </div>\\n        </div>\\n        <div>\\n            <br />\\n        </div>\\n    </div>\\n</div>"];
    
    [webView  stringByEvaluatingJavaScriptFromString:attr];
    
    
//    NSString *bodyString = @"document.body.outerHTML";
//    NSString *body = [webView  stringByEvaluatingJavaScriptFromString:bodyString];
    NSLog(@"%@",body);
 }





@end
