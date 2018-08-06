


#ifndef JYMacros_h
#define JYMacros_h

#define Screen_Bounds [UIScreen mainScreen].bounds
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度

/**
 
 非iPhone X ：
 StatusBar 高20px，NavigationBar 高44px，底部TabBar高49px
 iPhone X：
 StatusBar 高44px，NavigationBar 高44px，底部TabBar高83px
 */
#define kStatusHeight (iPhoneX ? 20.f : 0.f)
// 导航栏高度
#define kNavHeight (iPhoneX ? 85.f : 64.f)
// tabBar高度
#define kTabBarHeight (iPhoneX ? (49.f+34.f) : 49.f)


#define showView_Width Screen_Width * 0.8
#define showView_Height 225

#define UserDataFilePath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.plist"])


// // iOS系统版本 >= 11.0,不等于升序,就是等于和降序
#define SYSTEM_VERSION_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)



// 客服电话
//#define ServicePhone1 @"400-600-6656"
#define ServicePhone2 @"15119207733"


//高德地图apiKey
#define kApiKey @"cc8d7ec5aa91b7c005bec86740287539"

#define kTableId @"5aa0f165afdf5279c02be604"

#define kKeyword @"今优农场社区店"

#define kSearchCity @"全国"
/*----------------------------------URL 相关----------------------------------*/

// 正式环境
//#define MAIN_URL @"http://api.front.jinyoufarm.com/api"
//测试环境

#define MAIN_URL @"http://www.mocky.io/v2"


#define  SUCCESS [resposeObject[@"result"] integerValue] == 0

/*----------------------------------账号 相关----------------------------------*/

#define WX_APPID @"wx7efa688e09c7b175" //今优

/*----------------------------------function 相关----------------------------------*/
// 设置view圆角
#define kViewRadius(view, radius)\
\
[view.layer setCornerRadius:(radius)];\
[view.layer setMasksToBounds:YES]

//默认占位图片
#define defaultPlaceholderImage [UIImage imageNamed:@"placeholderImage"]
#define defaultFarmImage [UIImage imageNamed:@"defalut"]
// 系统字体大小定义
#define kFont(F)                                [UIFont systemFontOfSize:F]
//有点问题
//#define kFont(_fontSize_)  [UIFont systemFontOfSize:(_fontSize_ *([UIScreen mainScreen].scale) / 2)]

// RGB转UIColor（不带alpha值）十六进制
#define UIColorFromRGB(rgbValue)                [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// RGB转UIColor（带alpha值）十六进制
#define UIColorRGBAlpha(rgbValue,a)             [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

// 用于生成weakSelf
//#define WeakSelf(weakSelf)                          __weak typeof(&*self) weakSelf = self;
//#define kWeakSelf(type)                             __weak typeof(type) weak##type = type;
//#define kStrongSelf(type)                           __strong typeof(type) type = weak##type;

#define WeakSelf __weak typeof(self) weakSelf = self


//打印
#if DEBUG
#define NSLog(fmt,...) NSLog((@"%s [Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define NSLog(...)
#endif




#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define SCREEN_MAX_LENGTH (MAX(Screen_Width, Screen_Height))
#define SCREEN_MIN_LENGTH (MIN(Screen_Width, Screen_Height))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

/*----------------------------------color 相关----------------------------------*/
//背景色 浅灰色
//#define kGlobalColor  [UIColor colorWithHexString:@"F2F2F2"]
//背景色
#define kBgColor [UIColor colorWithHexString:@"F2F2F2"]
//主色 浅蓝色  如导航栏、商品按钮
#define kThemeColor   [UIColor colorWithHexString:@"62C6B2"]
//辅色 红色  如价格、删除
#define kRedColor   [UIColor colorWithHexString:@"FB483E"]
//辅色 蓝色 如我的页面图标
#define kBlueColor   [UIColor colorWithHexString:@"39A1ED"]

//文字  黑色 如导航、标题、正文
#define k3Color   [UIColor colorWithHexString:@"333333"]
//文字   浅灰色  如提示、正文
#define k6Color   [UIColor colorWithHexString:@"666666"]
//文字 浅灰色 如提示、正文
#define k9Color   [UIColor colorWithHexString:@"999999"]
//文字  白色
#define kfColor   [UIColor colorWithHexString:@"ffffff"]
//分割线颜色
#define kSeparatedLineColor   [UIColor colorWithHexString:@"DCDDDD"]

//浅灰色
#define kf2Color   [UIColor colorWithHexString:@"F2F2F2"]

/*----------------------------------字号 相关----------------------------------*/

/*---------------------首页常量----------------------*/

//全局tableView 行高
#define kTableView_rowHeight 44
//全局tableView 文字字体
#define kTableView_textFont 14
//全局按钮高度
#define kGlobalButtonHeight 44

//获取验证码的时间
#define kGlobalGetVaildCodeTime 60
//全局按钮的高度
#define kBtnHeight  44

#endif /* JYMacros_h */
