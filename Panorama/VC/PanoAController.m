//
//  PanoAController.m
//  安曼·养云村
//
//  Created by 凌甜 on 2020/1/9.
//  Copyright © 2020 com.ATT. All rights reserved.
//

#import "PanoAController.h"
#import "WeakWebViewScriptMessageDelegate.h"
#import "LTCustomBtn.h"
#import <WebKit/WebKit.h>
#import <KissXML.h>
#import "LTButton.h"

@interface PanoAController ()<WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) LTCustomBtn *lastSelectedBtn;
@property (nonatomic, strong) UIButton *lastSelectedHouseBtn;
@property (nonatomic, weak) UIView *choiceView;
@property (nonatomic, strong) NSMutableArray *imageVArr;
@property (nonatomic, strong) UIView *underView;
@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, strong) UIView *twoView;
@property (nonatomic,strong) UIView *threeView;
@property (nonatomic,strong) NSMutableArray *viewArr;
@property (nonatomic, strong) NSMutableArray *dataM;
@property (nonatomic, strong) NSMutableArray *allDataM;
@end

@implementation PanoAController

- (WKWebView *)webView{
    if(_webView == nil){
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = YES;
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        //config.applicationNameForUserAgent = @"ChinaDailyForiPad";
        config.preferences.minimumFontSize = 9.0;
        //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //  [self registerAllJavascriptWithUserContent:userContentController];
        [config.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
        [config setValue:@YES forKey:@"_allowUniversalAccessFromFileURLs"];
        
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"];
        
        config.userContentController = wkUController;
        
        //以下代码适配文本大小
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:wkUScript];
        
        _webView = [[WKWebView alloc] initWithFrame:kScreenBounds configuration:config];
        // UI代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
        
    }
    return _webView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self addChooseBtn];
    [self addHouseBtn];
    [self setupDataArr];
    [self houseBtnClick:self.houseView.subviews[1]];
    [self addBackBtn];
}

- (void)addBackBtn {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20 * 0.5 * kW,20 * 0.5 * kH, 90 * 0.8 * kW, 90 * 0.8 * kW)];
    [self.view addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeBtnClick {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)setupDataArr {
    self.dataM = [NSMutableArray array];
    self.allDataM = [NSMutableArray array];
    NSDictionary *dic = [self parseXMLWithPath:@"AUnder/pano.xml"];
    [self.dataM addObject:dic];
    NSMutableArray *dicArr = [NSMutableArray array];
    NSArray *dicarray = dic[@"node5"];
    [dicArr addObject:dicarray[1]];//地下室入口
    [dicArr addObject:dicarray[0]];//茶室
    [dicArr addObject:dicarray[2]];//会客厅
    NSArray *dicarray1 = dic[@"node4"];
    [dicArr addObject:dicarray1[0]];//走廊
    [dicArr addObject:dicarray1[2]];//茶室2
    [self.allDataM addObject:dicArr];
    NSDictionary *dic1 = [self parseXMLWithPath:@"AOne/pano.xml"];
    [self.dataM addObject:dic1];
    NSMutableArray *dic1Arr = [NSMutableArray array];
    NSArray *dic1array = dic1[@"node1"];
    [dic1Arr addObject:dic1array[0]];//会客厅1
    NSArray *dic1array1 = dic1[@"node2"];
    [dic1Arr addObject:dic1array1[1]];//会客厅2
    [dic1Arr addObject:dic1array1[2]];//餐厅
    NSArray *dic1array2 = dic1[@"node3"];
    [dic1Arr addObject:dic1array2[1]];//卧室
    [dic1Arr addObject:dic1array2[0]];//阳台
    [self.allDataM addObject:dic1Arr];
    NSDictionary *dic2 = [self parseXMLWithPath:@"ATwo/pano.xml"];
    [self.dataM addObject:dic2];
    NSMutableArray *dic2Arr = [NSMutableArray array];
    NSArray *dic2array = dic2[@"node5"];
    [dic2Arr addObject:dic2array[0]];//卧室1
    NSArray *dic2array1 = dic2[@"node4"];
    [dic2Arr addObject:dic2array1[2]];//卧室1卫生间
    NSArray *dic2array2 = dic2[@"node1"];
    [dic2Arr addObject:dic2array2[2]];//卧室2
    [dic2Arr addObject:dic2array1[1]];//走廊
     [dic2Arr addObject:dic2array2[0]];//阳台1
    [dic2Arr addObject:dic2array1[0]];//阳台2
    [self.allDataM addObject:dic2Arr];
}


- (NSDictionary *)parseXMLWithPath:(NSString *)str {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
    NSString *xmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    DDXMLDocument  *doc =  [[DDXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    //开始解析
    NSArray *children = [doc nodesForXPath:@"//panorama" error:nil];
    NSString *identify;
    for (DDXMLElement *obj in children) {
        identify =[[obj attributeForName:@"id"] stringValue];
        DDXMLElement *subChild = [obj elementForName:@"hotspots"];
        NSArray *hotspotsC = [subChild elementsForName:@"hotspot"];
        NSMutableArray *mArray = [NSMutableArray array];
        for (DDXMLElement *obj1 in hotspotsC) {
            NSString *title =[[obj1 attributeForName:@"title"] stringValue];
            NSString *url =[[obj1 attributeForName:@"url"] stringValue];
            NSString *target =[[obj1 attributeForName:@"target"] stringValue];
            NSArray *subArray = @[title,url,target];
            [mArray addObject:subArray];
        }
        [dic setValue:mArray forKey:identify];
    }
    
    return dic;
    //遍历每个元素
}

- (void)addChooseBtn {
    LTButton *btn = [[LTButton alloc] initWithFrame:CGRectMake(20 * kW, kScreenH - 75 *kH, 100 * 0.5 *kW, 160 * 0.5 *kH)];
    [btn setImage:[UIImage imageNamed:@"icon-cj"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn.font = [UIFont systemFontOfSize:12 *kW];
    [btn setTitle:@"场景选择" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cjBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - 200 * kH, kScreenW, 240 * 0.5 *kH)];
    bgView.backgroundColor = kARGBColor(0.2, 0, 0, 0);
    [self.view addSubview:bgView];
    self.viewArr = [NSMutableArray array];
    self.underView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * 0.5 *kW, 240 *0.5 *kW *5, 220 * 0.5 *kH)];
    [bgView addSubview:self.underView];
     self.choiceView = bgView;
    [self.viewArr addObject:self.underView];
    self.underView.k_centerX = bgView.center.x + 300 * 0.5 *kW;
    self.underView.alpha = 0.0;
    [self addChoiceBtnOnView:self.underView WithImageArr:@[@"A负一层地下室入口.jpg",@"A负一层茶室.jpg",@"A负一层地下室会客厅.jpg",@"A负一层走廊.jpg",@"A负一层茶室2.jpg"] WithTitleArr:@[@"地下室入口",@"茶室",@"地下室会客厅",@"走廊",@"茶室2"]];
    self.oneView = [[UIView alloc] initWithFrame:CGRectMake(0,10 * 0.5 *kW,240 *0.5 *kW *5, 220 * 0.5 *kH)];
    [bgView addSubview:self.oneView];
    self.oneView.k_centerX = bgView.center.x + 300 * 0.5 *kW;
    self.oneView.alpha = 0.0;
    [self.viewArr addObject:self.oneView];
    [self addChoiceBtnOnView:self.oneView WithImageArr:@[@"A一层会客厅1.jpg",@"A一层会客厅2.jpg",@"A一层餐厅.jpg",@"A一层卧室.jpg",@"A一层阳台.jpg"] WithTitleArr:@[@"一层会客厅1",@"一层会客厅2",@"一层餐厅",@"一层卧室",@"一层阳台"]];
    self.twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * 0.5 *kW, 240 *0.5 *kW *6, 220 * 0.5 *kH)];
    [bgView addSubview:self.twoView];
    self.twoView.k_centerX = bgView.center.x + 300 * 0.5 *kW;
    self.twoView.alpha = 0.0;
    [self.viewArr addObject:self.twoView];
    [self addChoiceBtnOnView:self.twoView WithImageArr:@[@"A二层卧室1.jpg",@"A二层卧室1卫生间.jpg",@"A二层卧室2.jpg",@"A二层走廊.jpg",@"A二层阳台1.jpg",@"A二层阳台2.jpg"] WithTitleArr:@[@"二层卧室1",@"二层卧室1卫生间",@"二层卧室2",@"走廊",@"二层阳台1",@"二层阳台2"]];
    
}

- (void)cjBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    [UIView animateWithDuration:0.25 animations:^{
        self.choiceView.k_Y = btn.selected? kScreenH-80 *kH : kScreenH-200 * kH;
        self.choiceView.alpha = btn.selected ?  0.0 : 1.0;
        self.houseView.alpha = btn.selected ?  0.0 : 1.0;
    }];
}

- (void)addHouseBtn {
    self.houseView = [[UIView alloc] initWithFrame:CGRectMake(kScreenW - 183 * 0.5 *kW, kScreenH - 200 *kH, 183 * 0.5 *kW, 78 * 0.5 *kH *3)];
    [self.view addSubview: self.houseView];
    NSArray *btnImageArr = @[@"houseUnder",@"houseOne",@"houseTwo"];
    for (int index = 0; index < btnImageArr.count; index++) {
        UIButton *customBtn = [[UIButton alloc] initWithFrame:CGRectMake(0* 0.5 * kW+ 0 * 0.5 *kW *index, 78 * 0.5 *kH *index, 183 * 0.5 * kW , 78 * 0.5 *kH)];
        [customBtn setBackgroundImage:[UIImage imageNamed:@"houseBtnBg"] forState:UIControlStateSelected];
        [customBtn setImage:[UIImage imageNamed:btnImageArr[index]] forState:UIControlStateNormal];
        [customBtn setImage:[UIImage imageNamed:btnImageArr[index]] forState:UIControlStateSelected];
        customBtn.tag = index;
        customBtn.imageView.alpha = 0.7;
        [customBtn addTarget:self action:@selector(houseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.houseView addSubview:customBtn];
    }
}

- (void)houseBtnClick:(UIButton *)btn {
    if (btn != self.lastSelectedHouseBtn) {
        btn.selected = YES;
        btn.imageView.alpha= 1.0;
        if (self.lastSelectedHouseBtn != nil) {
            self.lastSelectedHouseBtn.selected = NO;
            self.lastSelectedHouseBtn.imageView.alpha= 0.7;
            UIView *view = self.viewArr[self.lastSelectedHouseBtn.tag];
            [UIView animateWithDuration:0.5 animations:^{
                view.k_centerX+= 300 * 0.5 *kW;
                view.alpha = 0.0;
            }];
            if (self.lastSelectedBtn != nil) {
                 [self.lastSelectedBtn setBackgroundColor:[UIColor clearColor]];
            }
            self.lastSelectedBtn = nil;
        }
    }
    self.lastSelectedHouseBtn = btn;
    NSString *path;
    if (btn.tag == 0) {
        path = [[NSBundle mainBundle] pathForResource:@"AUnder/index" ofType:@"html"];
    }else if (btn.tag == 1) {
        path = [[NSBundle mainBundle] pathForResource:@"AOne/index" ofType:@"html"];
    }else if (btn.tag == 2) {
        path = [[NSBundle mainBundle] pathForResource:@"ATwo/index" ofType:@"html"];
    }
    NSError *error = nil;
    NSString *htmls = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error == nil) {
        NSURL *url = [[NSBundle mainBundle] bundleURL];
        [self.webView loadHTMLString:htmls baseURL:url];
    }
    UIView *view = self.viewArr[btn.tag];
    LTCustomBtn *btn1 = view.subviews[0];
    [btn1 setBackgroundColor:kARGBColor(1, 218, 140, 35)];
    self.lastSelectedBtn = btn1;
    [UIView animateWithDuration:0.5 animations:^{
        view.k_centerX-= 300 * 0.5 *kW;
        view.alpha = 1.0;
    }];
}


- (void)addChoiceBtnOnView:(UIView *)view WithImageArr:(NSArray *)imageArr WithTitleArr:(NSArray *)titleArr{
    for (int index = 0; index < imageArr.count; index ++) {
        LTCustomBtn *customBtn = [[LTCustomBtn alloc] initWithFrame:CGRectMake(0 * kW+ 240 * 0.5 *kW *index, 0* 0.5 *kH, 220 * 0.5 * kW , 220 * 0.5 *kW)];
        [customBtn setImage:[UIImage imageNamed:imageArr[index]] forState:UIControlStateNormal];
        [customBtn setImage:[UIImage imageNamed:imageArr[index]] forState:UIControlStateSelected];
        [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        customBtn.font = [UIFont systemFontOfSize:12 *kW];
        [customBtn setTitle:titleArr[index] forState:UIControlStateNormal];
        [customBtn setTitle:titleArr[index] forState:UIControlStateSelected];
        customBtn.tag = index;
        [customBtn addTarget:self action:@selector(customBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:customBtn];
        if (index == 0) {
            [customBtn setBackgroundColor:kARGBColor(1, 218, 140, 35)];
        }
    }
}


- (void)customBtnClick:(LTCustomBtn *)customBtn {
    if (customBtn != self.lastSelectedBtn) {
        [customBtn setBackgroundColor:kARGBColor(1, 218, 140, 35)];
        if (self.lastSelectedBtn != nil) {
            [self.lastSelectedBtn setBackgroundColor:[UIColor clearColor]];
        }
        NSDictionary *dic = self.dataM[self.lastSelectedHouseBtn.tag];
        NSArray *allDataArr = self.allDataM[self.lastSelectedHouseBtn.tag];
        NSArray *array;
        NSArray *subArray;
        if (self.lastSelectedHouseBtn.tag == 0) {
            if (self.lastSelectedBtn.tag == 0) {//地下室入口  node3
                array = dic[@"node3"];
                if (customBtn.tag == 3) {
                    subArray = array[0];
                }else{
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 1){//负一层茶室 node1
                array = dic[@"node1"];
                if (customBtn.tag == 2){
                    subArray = array[0];
                }else{
                   subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 2) {//会客厅 node4
                array = dic[@"node4"];
                if (customBtn.tag == 1){
                    subArray = array[1];
                }else if (customBtn.tag == 3){
                    subArray = array[0];
                }else if (customBtn.tag == 4){
                    subArray = array[2];
                }else {
                   subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 3) {//走廊 node5
                array = dic[@"node5"];
                if (customBtn.tag == 0){
                   subArray = array[1];
                }else if (customBtn.tag == 1) {
                   subArray = array[0];
                }else if (customBtn.tag == 2) {
                    subArray = array[2];
                }else {
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 4) {//茶室2 node2
                array = dic[@"node2"];
                if (customBtn.tag == 2){
                    subArray = array[0];
                }else {
                    subArray = allDataArr[customBtn.tag];
                }
            }
        }else if (self.lastSelectedHouseBtn.tag == 1) {
            if (self.lastSelectedBtn.tag == 0) {//一层会客厅1  node2
               array = dic[@"node2"];
                if (customBtn.tag == 1) {
                    subArray = array[1];
                }else if (customBtn.tag == 2){
                    subArray = array[2];
                }else if (customBtn.tag == 3){
                    subArray = allDataArr[customBtn.tag];
                }else if (customBtn.tag == 4){
                   subArray = array[0];
                }
            }else if (self.lastSelectedBtn.tag == 1){//餐厅 node1
               array = dic[@"node1"];
                if (customBtn.tag == 0){
                    subArray = array[0];
                }else if (customBtn.tag == 2){
                    subArray = allDataArr[customBtn.tag];
                 }else if (customBtn.tag == 3) {
                    subArray = allDataArr[customBtn.tag];
                }else if (customBtn.tag == 4) {
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 2) {
                array = dic[@"node3"];
                if (customBtn.tag == 0){
                   subArray = array[0];
                }else if (customBtn.tag == 3){
                    subArray = array[1];
                }else {
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 3) {
                   array = dic[@"node4"];
                    if (customBtn.tag == 0){
                      subArray = array[0];
                    }else if (customBtn.tag == 4) {
                       subArray = array[1];
                    }else {
                        subArray = allDataArr[customBtn.tag];
                    }
            }else if (self.lastSelectedBtn.tag == 4) {
                array = dic[@"node5"];
                if (customBtn.tag == 3){
                    subArray = array[0];
                }else if (customBtn.tag == 2) {
                   subArray = array[1];
                }else {
                   subArray = allDataArr[customBtn.tag];
                }
            }
            
        }else {
            if (self.lastSelectedBtn.tag == 0) {//卧室1  node4
                array = dic[@"node4"];
                if (customBtn.tag == 1) {
                    subArray = array[2];
                }else if (customBtn.tag == 3){
                    subArray = array[1];
                }else if (customBtn.tag == 4){
                    subArray = array[0];
                }else {
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 1){//卧室1卫生间 node5
                array = dic[@"node5"];
                if (customBtn.tag == 0){
                    subArray = array[0];
                }else{
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 2) {//卧室2 node6
                array = dic[@"node6"];
                if (customBtn.tag == 3){
                    subArray = array[0];
                }else {
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 3) {//走廊 node1
               array = dic[@"node1"];
                if (customBtn.tag == 0){
                    subArray = array[1];
                }else if (customBtn.tag == 2) {
                    subArray = array[2];
                }else if (customBtn.tag == 4) {
                    subArray = array[0];
                }else {
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 4) {//阳台1 node2
                 array = dic[@"node2"];
                if (customBtn.tag == 3){
                subArray = array[0];
                }else {
                    subArray = allDataArr[customBtn.tag];
                }
            }else if (self.lastSelectedBtn.tag == 5) {//阳台2 node3
                array = dic[@"node3"];
                if (customBtn.tag == 2){
                    subArray = array[0];
                }else {
                   subArray = allDataArr[customBtn.tag];
                }
            }
        }
        [self executeJsWithStr1:subArray[1] Str2:subArray[2]];
    }
    self.lastSelectedBtn = customBtn;
    
}

- (void)executeJsWithStr1:(NSString *)str1 Str2:(NSString *)str2 {
    NSString *jsString = [NSString stringWithFormat:@"skin.player.openNext('%@',%@)",str1,str2];
    [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
       // NSLog(@"%@,%@",data,error);
    }];
}
    // 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
        [self getCookie];
    }
    //被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
    //通过接收JS传出消息的name进行捕捉的回调方法
    - (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
        //NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
        //用message.body获得JS传出的参数体
        NSDictionary * parameter = message.body;
        //JS调用OC
        NSString *str = parameter[@"params"];
        if([message.name isEqualToString:@"jsToOcWithPrams"]){
            UIView *btnView = self.viewArr[self.lastSelectedHouseBtn.tag];
            LTCustomBtn *btn;
            if (self.lastSelectedHouseBtn.tag == 0) {
                if ([str  isEqual: @"{node3}"]) {
                    btn = btnView.subviews[0];
                }else if ([str  isEqual: @"{node1}"]){
                    btn = btnView.subviews[1];
                }else if ([str  isEqual: @"{node4}"]){
                    btn = btnView.subviews[2];
                }else if ([str  isEqual: @"{node5}"]){
                    btn = btnView.subviews[3];
                }else if ([str  isEqual: @"{node2}"]){
                    btn = btnView.subviews[4];
                }
            }else if (self.lastSelectedHouseBtn.tag == 1) {
                if ([str  isEqual: @"{node2}"]) {
                    btn = btnView.subviews[0];
                }else if ([str  isEqual: @"{node3}"]){
                    btn = btnView.subviews[1];
                }else if ([str  isEqual: @"{node1}"]){
                    btn = btnView.subviews[2];
                }else if ([str  isEqual: @"{node4}"]){
                    btn = btnView.subviews[3];
                }else if ([str  isEqual: @"{node5}"]){
                    btn = btnView.subviews[4];
                }
            }else {
                if ([str  isEqual: @"{node4}"]) {
                    btn = btnView.subviews[0];
                }else if ([str  isEqual: @"{node5}"]){
                    btn = btnView.subviews[1];
                }else if ([str  isEqual: @"{node6}"]){
                    btn = btnView.subviews[2];
                }else if ([str  isEqual: @"{node1}"]){
                    btn = btnView.subviews[3];
                }else if ([str  isEqual: @"{node2}"]){
                    btn = btnView.subviews[4];
                }else if ([str  isEqual: @"{node3}"]){
                    btn = btnView.subviews[5];
                }
            }
            [btn setBackgroundColor:kARGBColor(1, 218, 140, 35)];
            if (self.lastSelectedBtn != nil) {
                [self.lastSelectedBtn setBackgroundColor:[UIColor clearColor]];
            }
            self.lastSelectedBtn = btn;
        }
    }

    
    //解决 页面内跳转（a标签等）还是取不到cookie的问题
    - (void)getCookie{
        
        //取出cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        //js函数
        NSString *JSFuncString =
        @"function setCookie(name,value,expires)\
        {\
        var oDate=new Date();\
        oDate.setDate(oDate.getDate()+expires);\
        document.cookie=name+'='+value+';expires='+oDate+';path=/'\
        }\
        function getCookie(name)\
        {\
        var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
        if(arr != null) return unescape(arr[2]); return null;\
        }\
        function delCookie(name)\
        {\
        var exp = new Date();\
        exp.setTime(exp.getTime() - 1);\
        var cval=getCookie(name);\
        if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
        }";
        
        //拼凑js字符串
        NSMutableString *JSCookieString = JSFuncString.mutableCopy;
        for (NSHTTPCookie *cookie in cookieStorage.cookies) {
            NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
            [JSCookieString appendString:excuteJSString];
        }
        //执行js
        [_webView evaluateJavaScript:JSCookieString completionHandler:nil];
        
    }

    
- (void)dealloc{
        //移除注册的js方法
        [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcWithPrams"];
    ZHYLogFunc;
    }


@end
