platform :ios, '11.0'

workspace 'Swift_BaseSpace.xcworkspace'

use_frameworks!

# 屏蔽所有第三方框架警告
inhibit_all_warnings!

# source 'https://github.com/CocoaPods/Specs.git'
# source 'https://cdn.cocoapods.org/'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

# -------------- 指令 --------------

# pod install --no-repo-update 跳过检查更新
# pod install
# pod install --repo-update 检查更新
# 更新指定库名的第三个库，其他库不更新：pod update 库名 --verbose --no-repo-update
# 更新所有的第三方库：pod update --verbose --no-repo-update
# 只安装新增的库，已经安装的库不更新 pod install --verbose --no-repo-update
# removing SDWebImage


# pod --version 查看版本
# sudo gem update cocoapods 更新升级CocoaPods
# sudo gem update --system  更新升级gem
# sudo gem install -n /usr/local/bin cocoapods 安装CocoaPods

# -------------- Swift --------------
target 'Swift_Base' do
  project 'Swift_Base/Swift_Base.xcodeproj'  #这里的project要指明路径
# 网络请求
  pod 'Alamofire', '4.9.1'              # MoyaHttpTool.swift   # HTTP 网络请求库  https://github.com/Alamofire/Alamofire
  pod 'Moya', '13.0.1'                  # MoyaHttpTool.swift
  pod 'ReachabilitySwift', '5.0.0'      # ReachabilityTool.swift
# 模型转换，数据处理
  pod 'SwiftyJSON', '5.0.1'             # MoyaHttpTool.swift # SON 解析库，它可以帮助你快速地将 JSON 数据解析为Swift对象
  pod 'ObjectMapper'                    # Installing ObjectMapper (4.2.0)
  pod 'HandyJSON', '5.0.2'              # JsonUtils.swift
# 自动布局
  pod 'SnapKit', '4.2.0'                # 自动布局库，它使用简单的 DSL https://github.com/SnapKit/SnapKit
# 网络图片加载缓存
  pod 'Kingfisher', '6.3.1'             # 图片下载和缓存库  https://github.com/onevcat/Kingfisher
  #pod 'KingfisherWebP'
  pod 'IQKeyboardManagerSwift', '6.5.9' #AppDelegate+Extension
  #pod 'Gifu', '3.3.1'
# 数据存储与数据安全
  #pod 'SQLite.swift', '0.13.2'
  #pod 'RealmSwift'

  #SwiftyUserDefaults 是一个 Swift 编写的 UserDefaults 库，它提供了一个类型安全的 API 来访问 UserDefaults 中的数据，避免了使用字符串键名的问题。      https://github.com/sunshinejr/SwiftyUserDefaults
  #pod 'SwiftyUserDefaults', '5.3.0'
  
  #pod 'KeychainAccess'
  #pod 'Cache', '5.3.0'
  #pod 'CryptoSwift', '1.4.3'
# 时间转换
  #pod 'SwiftDate', '6.3.1'
# 标准库扩展
  #pod 'Dollar', '9.0.0'
# 扩展库
  #pod 'SwifterSwift'
# 日志
  #pod 'XCGLogger'
  #pod 'Log'
# 异步、函数响应式编程
  pod 'RxSwift', '6.8.0'  # RxSwift 是一个 Swift 编写的响应式编程库，它提供了一种简单、一致、高效的方式来处理异步事件，包括网络请求、UI 事件等。
  pod 'RxCocoa', '6.8.0'
  #pod 'PromiseKit'
  #pod 'AsyncSwift'
  #pod 'RxBlocking'#, '6.6.0'
  #pod 'RxTest'#, '6.6.0'         pod 'libwebp'

# 主题和颜色
  #pod 'SwiftTheme', '0.6.4' # 主题
  #pod 'UIImageColors' # 从图像中获取最主要和最突出的颜色
  #pod 'Hue'
  #pod 'DynamicColor'
  #pod 'UIColor_Hex_Swift'
# 弹框
  #pod 'SCLAlertView', '0.8' # 标题上方带图片
  
  # SwiftMessages 是一个 Swift 编写的通知和消息库，它提供了许多不同的消息样式和配置选项，非常适合移动应用程序开发。                                     https://github.com/SwiftKickMobile/SwiftMessages
  #pod 'SwiftMessages', '9.0.6'
  
  #pod 'BulletinBoard'
  #pod 'FloatingPanel' # 浮动界面
  #pod 'XLActionController' # 底部菜单栏控件
# 弹框
  pod 'Toast-Swift', '5.0.1'  # Toast.swift
  #pod 'PKHUD'
  #pod 'ProgressHUD'
  #pod 'Toaster'
  # pop
  #pod 'Popover', '1.3.0'
  #pod 'PopupDialog'
  #pod 'AMPopTip'
# 顶部
  #pod 'SwiftEntryKit', '2.0.0'
  #pod 'NotificationBannerSwift'
# 加载动画
# NVActivityIndicatorView 是一个 Swift 编写的加载指示器库，它提供了许多不同的加载指示器样式，并支持自定义。                                       https://github.com/ninjaprox/NVActivityIndicatorView
  pod 'NVActivityIndicatorView'
# 图片选择器
  #pod 'HXPHPicker', '1.0.8'
  #pod 'ZLPhotoBrowser'
  #pod 'YPImagePicker'
  #pod 'BSImagePicker'
  #pod 'ImagePicker'
# 图片浏览
  #pod 'Lantern', '1.1.2'
  #pod 'JXPhotoBrowser'
  #pod 'ImageViewer'
# 滑动面板
  #pod 'JXSegmentedView'
  #pod 'Panels'
# 轮播
  #pod 'FSPagerView', '0.8.3'
# 侧滑菜单
  #pod 'SideMenu', '5.0.1'
  #pod 'SlideMenuControllerSwift'
  #pod 'ESTabBarController-swift', '2.8.0'
  #pod 'RAMAnimatedTabBarController'
# 引导页
  #pod 'Instructions', '2.3.0'
  #pod 'RazzleDazzle'
  #pod 'ZLaunchAd'
# 二维码
  #pod 'EFQRCode', '6.2.1'
  #pod 'swiftScan', '1.2.1'
  #pod 'WeScan'
# 图表 SwiftUICharts
  #pod 'AAInfographics', '9.0.0'
  #pod 'AAInfographics', :git => 'https://github.com/AAChartModel/AAChartKit-Swift.git'
  #pod 'Charts'
  #pod 'SwiftCharts'
  #pod 'SwiftChart' # 最后更新2018
  #pod 'PNChartSwift',:git => 'https://github.com/kevinzhow/PNChart-Swift.git' # 最后更新2017
# 富文本
  #pod 'SwiftyAttributes'
  #pod 'Atributika'
  #pod 'SwiftRichString'
  #pod 'TextAttributes'
# 日历
  #pod 'JTAppleCalendar', '7.1.7'
  #pod 'CVCalendar'
  #pod 'HorizonCalendar'
  #pod 'CalendarKit'
# 下拉刷新
#  pod 'DGElasticPullToRefresh'
  pod 'CRRefresh'   # BaseTableView
  #pod 'ESPullToRefresh', '2.9.3'
  #pod 'PullToRefresher'
# UI
  #pod 'Eureka' # 表单
  #pod 'Former' # 表单
  #pod 'FoldingCell' # 折叠cell
  #pod 'SwipeCellKit' # 滑动cell
  #pod 'Reusable' #cell
  #pod 'ActiveLabel'
  #pod 'LTMorphingLabel'
  #pod 'MarqueeLabel'
  #pod 'TextFieldEffects' # 浮动输入
  #pod 'SkyFloatingLabelTextField' # 浮动输入
  #pod 'RichTextView'
  #pod 'NextGrowingTextView'
  #pod 'PhoneNumberKit'
  #pod 'Cosmos', '~> 23.0' # 星星评分
  #pod 'RAMPaperSwitch'
  #pod 'Koloda'
  #pod 'JXMarqueeView' # 跑马灯
# 音视频
  #pod 'BMPlayer'
  #pod 'Player'
# web
  #pod 'vapor'
  #pod 'Swifter'
  #pod 'SwiftSoup' # HTML解析
  #pod 'Starscream' # WebSocket
# 其它
  #pod 'URLNavigator' # 路由
  #pod 'BluetoothKit' # 蓝牙
  #pod 'Appz' # App跳转
  #pod 'MonkeyKing' # 社会化分享
  #pod 'Siren'  # 版本检查
  #pod 'Tiercel' # 资源下载
  #pod 'R.swift' # 资源使用
  #pod 'SwiftGen' # 资源管理
  #pod 'SwiftLocation'
  #pod 'SwiftOCR'
  #pod 'OAuthSwift'
  #代码检查工具，它可以帮助你在编写 Swift 代码时遵守一致的编码规范，并自动检查代码中的错误和潜在问题。https://github.com/realm/SwiftLint
  #pod 'SwiftLint'

# -------------- OC --------------
#  pod 'AFNetworking', '4.0.1'
  pod 'DZNEmptyDataSet','1.8.1' #BaseTableView 有用
  pod 'MJRefresh','3.7.2'
#  pod 'Masonry','1.1.0'
  pod 'SVProgressHUD','2.2.5'
  pod 'MBProgressHUD', '1.1.0'
#  pod 'LEEAlert','1.5.1'
#  pod 'BRPickerView','2.7.6'
# ios14适配 SDWebImage升级到至少5.8.3版本，防止图片不显示、黑屏
#  pod 'SDWebImage','5.12.1'
  #pod 'IQKeyboardManager','6.5.9'
# 选择图片依赖HXPhotoPicker和SDWebImage，可以分开加或者使用： pod 'HXPhotoPicker/SDWebImage', '3.1.9'
  #pod 'HXPhotoPicker'
  #pod 'FDFullscreenPopGesture', '1.1' #全屏手势 拖进来了
  #pod 'GKPhotoBrowser','2.2.1'
  #pod 'PPBadgeView','2.1.0'  #小红点
end
# --------------------------------

# target 'MultiTabKit' do  #这里举例添加库
#     project 'WSComs/MultiTabKit/MultiTabKit.xcodeproj'
# end

# 更改所有第三方框架 Target 版本
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
