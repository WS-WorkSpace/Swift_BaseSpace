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
  #pod 'SQLite.swift', '0.13.2'             # SQLite.swift:用swift封装的sqlite 3操作框架。
  #pod 'RealmSwift'

  #SwiftyUserDefaults 是一个 Swift 编写的 UserDefaults 库，它提供了一个类型安全的 API 来访问 UserDefaults 中的数据，避免了使用字符串键名的问题。      https://github.com/sunshinejr/SwiftyUserDefaults
  #pod 'SwiftyUserDefaults', '5.3.0'
  
  #pod 'KeychainAccess'
  #pod 'Cache', '5.3.0'
  
  # CryptoSwift 是一个 Swift 编写的加密库，它提供了许多常用的加密算法和工具，包括 AES、SHA、HMAC 等。                                              https://github.com/krzyzanowskim/CryptoSwift
  #pod 'CryptoSwift', '1.4.3'
  
# 时间转换
  #pod 'SwiftDate', '6.3.1'
# 标准库扩展
  #pod 'Dollar', '9.0.0'
  #pod 'ExSwift'    # ExSwift: 包含一组标准类型和类的Swift扩展。

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
  #pod 'R.swift' # 资源使用     # R.swift:以一种优雅安全的方式使用资源文件。
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





# FillableLoaders:自定义的进度加载器，有waves、plain、spike、rounded等效果。
# Design-Patterns-In-Swift:swift实现的各种设计模式。
# KeychainAccess:使用Keychain非常方便。
# DGElasticPullToRefresh:有弹性效果的下拉刷新控件。
# IFTTT/RazzleDazzle:集成引导页，具有不错的动画效果。
# Instructions:应用于操作指南、新手教程。
# Animated Tab Bar：Ramotion出品,给tabbar items各单元添加动画效果。
# Adaptive Tab Bar:同样的Ramotion出品，提供适合的Tab Bar。
# folding-cell:折叠的cell效果，动画很nice。
# SCLAlertView-Swift:不错的一款alert view。
# SweetAlert-iOS:alert。
# LTMorphingLabel:拥有很多种特性的label。
# ActiveLabel.swift:支持Hashtags、Mentions、Links响应事件处理。
# TextFieldEffects:具有非常多、非常nice的输入框视图。
# PhoneNumberKit:专门针对电话号码格式做的一个输入框，很赞。
# SkyFloatingLabelTextField:类似于OC的JVFloatLabeledTextField，编辑就会出现浮动的提示label。
# FloatLabelFields:类似于SkyFloatingLabelTextField。
# NextGrowingTextView:取自于HPGrowingTextView,文本输入视图，对于消息编辑非常有用。
# Hue:集成color功用的库，使用的是hex颜色值。
# TextAttributes:封装NSAttributedString的框架，让attributed strings处理更加简单，而且是链式结构，看起来更加直观。
# GPUImage2:GPUImage的Swift版，GPU加速image和video的处理。


# Swift 编写的 JSON 和对象映射库，它可以帮助你快速地将 JSON 数据映射为 Swift 对象，并支持复杂的嵌套关系。 https://github.com/tristanhimmelman/ObjectMapper
#pod 'ObjectMapper', '~> 3.5' (check releases to make sure this is the latest version)

# RealmSwift 是一个 Swift 编写的本地数据库库，它提供了一个简单的 API 来帮助你创建和管理本地数据库，非常适合移动应用程序开发。                           https://github.com/realm/realm-swift
# pod 'RealmSwift', '~>10'

# Charts 是一个 Swift 编写的图表库，它支持许多不同类型的图表，包括线形图、柱形图、饼图等，非常适合数据可视化应用程序开发。                               https://github.com/danielgindi/Charts
# github "danielgindi/Charts" == 5.0.0
# github "danielgindi/Charts" ~> 5.0.0
# PNChart-Swift:周凯文写的PNChart的swift版

# SwiftyBeaver 是一个 Swift 编写的日志库，它提供了许多实用的日志记录和分析功能，并支持多种日志输出方式，包括控制台、文件、网络等。                        https://github.com/SwiftyBeaver/SwiftyBeaver
# pod 'SwiftyBeaver'


#    网络
#    Alamofire:http网络请求事件处理的框架。
#
#    Moya:这是一个基于Alamofire的更高层网络请求封装抽象层。
#
#    Reachability.swift:用来检查应用当前的网络连接状况。
#
#    综合
#    Perfect:swift的服务器端开发框架（针对于移动后端开发、网站和web应用程序开发）。
#
#    RxSwift:
#    函数响应式编程框架，是ReactiveX的swift版本，可以简化异步操作和事件/数据流。
#
#    Dollar:无需扩展任何内置对象就为Swift语言提供有效的函数式编程辅助方法,类似于Lo-Dash或JavaScript中的Underscore。
#
#    MonkeyKing:社会化分享框架，支持分享text、url、image、audio、file到WeChat、QQ、Alipay、Weibo。
#
#    OAuthSwift:国外主流网站OAuth授权库。
#
#    R.swift:以一种优雅安全的方式使用资源文件。
#
#    Design-Patterns-In-Swift:swift实现的各种设计模式。
#
#    Whisper:使用简单、功能实用的消息及应用通知组件。
#
#    Surge:mattt写的性能加速框架，为数字信号处理和图像处理提供高性能。
#
#    Animation
#    Spring:MengTo写的动画框架，买过他的书《Design+Code》。
#
#    EasyAnimation:主要应用于UIView.animateWithDuration(_:, animations:...)。
#
#    IBAnimatable:主要使用于Interface Builder,不需要一行代码就可打造拥有炫酷动画效果的UI界面。
#
#    Advance:可应用于 iOS、 tvOS、 and OS X的动画框架。
#
#    PeekPop:使用3D touch 被引用的两个动画特性peek、pop。
#
#    Transition
#    StarWars.iOS:很炫酷的转场动画效果，视图碎片化掉落。
#
#    其他动画
#    NumberMorphView:label数字变形过渡动画，用于金额数字变动或者时间上面会非常nice！
#
#    FillableLoaders:自定义的进度加载动画。
#
#    数据处理
#    SQLite.swift:用swift封装的sqlite 3操作框架。
#
#    解析、转换
#    SwiftyJSON：很好、很方便地处理JSON数据。
#
#    Argo:函数式json解析转换库。
#
#    ObjectMapper:把json对象映射为model对象。
#
#    存储
#    SwiftyUserDefaults:对NSUserDefaults的封装，让NSUserDefaults使用更简单。
#
#    KeychainAccess:使用Keychain非常方便。
#
#    其他
#    SwiftString:关于swift中string处理的扩展，有between(left, right)、camelize()、capitalize()、count(string)、decodeHTML()、contains(substring)等。
#
#    ReSwift:单向数据流处理，灵感来自于redux。
#
#    Category、Extension
#    ExSwift: 包含一组标准类型和类的Swift扩展。
#
#    加载指示、HUD
#    NVActivityIndicatorView:很多漂亮的加载指示器。
#
#    FillableLoaders:自定义的进度加载器，有waves、plain、spike、rounded等效果。
#
#    Refresh
#    DGElasticPullToRefresh:有弹性效果的下拉刷新控件。
#
#    图表、绘画
#    Charts:非常好的图表框架，类似于MPAndroidChart。
#
#    PNChart-Swift:周凯文写的PNChart的swift版。
#
#    AutoLayout
#    SnapKit:自动布局框架，类似于Masonry。（推荐）
#
#    Cartography:自动布局DSL。
#
#    Neon:一款关于UI自动布局的框架。
#
#    Stevia:自动布局。
#
#    TZStackView:UISatckView的代替品，支持iOS7+。
#
#    UIKit
#    Chatto:轻量级构建聊天应用的框架。
#
#    Koloda:卡片视图，而且滑动视图有滑动卡片一样的动画效果。
#
#    ImagePicker:图片选择器。
#
#    MaterialKit:关于Material design做的一系列UI组件。
#
#    Material:集Animation和UI与一身，还有Icon、Color等元素，使用这个库就可以打造一个漂亮的UI界面并具有优雅的动画效果。
#
#    引导页、新手教程
#    IFTTT/RazzleDazzle:集成引导页，具有不错的动画效果。
#
#    Instructions:应用于操作指南、新手教程。
#
#    Tab Bar
#    Animated Tab Bar：Ramotion出品,给tabbar items各单元添加动画效果。
#
#    Adaptive Tab Bar:同样的Ramotion出品，提供适合的Tab Bar。
#
#    Table View
#    Eureka:通过详细的映射，创建动态的table-view forms。
#
#    folding-cell:折叠的cell效果，动画很nice。
#
#    Alert、Sheet
#    SCLAlertView-Swift:不错的一款alert view。
#
#    SweetAlert-iOS:alert。
#
#    Button
#    DOFavoriteButton:有动画效果的button，适用于收藏、喜欢、点赞等。
#
#    hamburger-button: hamburger button，动画过渡不错。
#
#    Switch
#    paper-switch:Ramotion出品，turned on覆盖父视图的动画效果。
#
#    Label
#    LTMorphingLabel:拥有很多种特性的label。
#
#    ActiveLabel.swift:支持Hashtags、Mentions、Links响应事件处理。
#
#    TextField
#    TextFieldEffects:具有非常多、非常nice的输入框视图。
#
#    PhoneNumberKit:专门针对电话号码格式做的一个输入框，很赞。
#
#    SkyFloatingLabelTextField:类似于OC的JVFloatLabeledTextField，编辑就会出现浮动的提示label。
#
#    FloatLabelFields:类似于SkyFloatingLabelTextField。
#
#    TextView
#    NextGrowingTextView:取自于HPGrowingTextView,文本输入视图，对于消息编辑非常有用。
#
#    Font、Color
#    Hue:集成color功用的库，使用的是hex颜色值。
#
#    CoreText、AttributeText
#    TextAttributes:封装NSAttributedString的框架，让attributed strings处理更加简单，而且是链式结构，看起来更加直观。
#
#    Image
#    GPUImage2:GPUImage的Swift版，GPU加速image和video的处理。
#
#    图片加载、缓存
#    Kingfisher:喵神王巍写的一款关于图片下载、缓存的框架，灵感取自于SDWebImage。
#
#    HanekeSwift:轻量带缓存高性能图片加载组件。
#
#    Gif
#    Gifu:加载gif的框架，表现良好。
#
#    JWAnimatedImage:加载gif和apng的引擎，低内存和cpu消耗。
#
#    特殊效果
#    Filterpedia:给图片加滤镜效果，有很多种滤镜。
#
#    Toucan:图片处理，支持重设尺寸、裁剪、风格化等
#
#    Menu
#    FlowingMenu:很有意思的一个menu,具有平滑的弹簧效果，且手势拖动动画特别有趣。
#
#    ENSwiftSideMenu:手势侧滑menu。
#
#    CircleMenu:简单、优雅的一款circle menu,有不错的动画效果。
#
#    Page Menu
#    PageMenu:滑动出现不同分页的一个pagemenu，用于不同状态分页效果上是很好的选择。
#
#    XLPagerTabStrip:功能同上，类似于android的PageTabStrip。
#
#    测试
#    Quick:测试框架，支持Swift和OC，灵感来自于 RSpec, Specta, and Ginkgo。
#
#    Sleipnir:BDD测试框架，灵感来自于OC写的cedar。
#
#    日志、Log
#    XCGLogger:功能完整的日志管理库。
#
#    Log:强有力的日志框架。
#
#    工具、插件
#    Carthage:包管理工具，类似于CocoaPod。
#
#    swift-package-manager:同样的，包管理工具。
#
#    SwiftLint: 一个用于检查 Swift 编程风格和约定的试验性工具。
#
#    其他
#    TSWeChat:仿Wechat。
#
#    FlappySwift:游戏flappy bird的swift实现。
#
#    OCR
#    SwiftOCR:ocr图像识别库。
#
#    Asynchronous
#    PromiseKit:能提供强大的 iOS 开发异步功能,非常容易使用。
#
#    Async:关于GCD异步分发的语法糖。
#
#    KVO
#    Observable-Swift:用于kvo的库。
#
#    Permission
#    PermissionScope:统一许可管理。（推荐）
#
#    Permission:统一管理iOS系统的许可，比如相机、相片、定位等。
#
#    App内购
#    SwiftyStoreKit:封装的轻量级的APP内购框架。
#
#    Bluetooth
#    BluetoothKit:使用蓝牙更方便。
#
#    App间跳转、DeepLink
#    Appz:非常方便地实现App间跳转和DeepLink。
#
#    状态机
#    SwiftTask:用Swift编写的状态机，综合了 Promise + progress + pause + cancel，使用SwiftState。
#
#    算法以及数据结构
#    swift-algorithm-club:swift中的算法以及数据结构，还有解释说明。
#
#    开源APP
#    Yep:周凯文团队开源的一个社交APP,对于学习swift开发整个项目非常有价值。
#
#    资料、资源
#    iOS-9-Sampler:关于iOS9新特性的所有demo。
#
#    iOS9-day-by-day:day-by-day系列相信很多人都很熟悉，主要介绍一些新特性、新框架的使用。
#
#    30DaysofSwift:作者Allen Wang是一名产品设计师，这是他学习swift的项目，在dribbble上看到过他的设计作品：openallen，挺不错的。
#
#    SwiftGuide:这份指南汇集了Swift语言主流学习资源，并以开发者的视角整理编排。
#
#    Awesome-Swift-Education:swift学习资源整理。
#
#    awesome-swift:swift资源大合集，覆盖了几乎所有方面。
#
#    awesome-ios:iOS开发资源大整合，包括OC、Swift，涉及到frameworks、libraries、tutorials、xcode plugins、components等。
