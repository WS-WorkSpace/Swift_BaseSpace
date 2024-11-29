//
//  ConfigFontColorMacro.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/7/30.
//

import UIKit


// MARK: - dark mode 配置

/// 是否开启暗黑模式，iOS13之后生效，在info设置UIUserInterfaceStyle禁用则不起作用
let RD_IsOpenDarkMode = true

/// 设置动态颜色
func DynamicColor(_ lightColor: UIColor, _ darkColor: UIColor) -> UIColor {
    return RD_IsOpenDarkMode==false ? UIColor.RD_dynamicColor(lightColor, lightColor) : UIColor.RD_dynamicColor(lightColor, darkColor)
}

/// 设置动态颜色（十六进制，color：支持“#123456” ）
func DynamicHexColor(_ lightColor: String, _ darkColor: String) -> UIColor {
    return RD_IsOpenDarkMode==false ? UIColor.RD_dynamicHexColor(lightColor, lightColor) : UIColor.RD_dynamicHexColor(lightColor, darkColor)
}

/// 设置动态图片
func DynamicImage(_ lightImage: String, _ darkImage: String) -> UIImage {
    return RD_IsOpenDarkMode==false ? UIImage.RD_dynamicImage(lightImage, lightImage) : UIImage.RD_dynamicImage(lightImage, darkImage)
}

// MARK: - 项目颜色

/// 主题色
let BaseThemeColor = UIColor.rgbColor(65, 191, 49)
let BaseThemeGreenColor = UIColor.rgbColor(0, 190, 102)
/// 背景色
let BaseBgColor = DynamicColor(BaseBgColor_Light, BaseBgColor_Dark)
let BaseBgColor_Light = UIColor.rgbColor(248, 248, 248)
let BaseBgColor_Dark = UIColor.grayColor(17)
/// 基础黑
let BaseBlackTextColor = UIColor.rgbColor(51, 51, 51)
let BaseBlackTextColor_Dark = UIColor.grayColor(198)
/// 浅灰色
let BaseLightGreyTextColor = UIColor.rgbColor(119, 119, 119)
let BaseLightGreyTextColor_Dark = UIColor.grayColor(120)

/// Label颜色
let BaseLabelColor = DynamicColor(BaseBlackTextColor, BaseBlackTextColor_Dark)
/// title Label颜色
let BaseTitleLabelColor = DynamicColor(BaseBlackTextColor, BaseBlackTextColor_Dark)
/// info Label颜色
let BaseInfoLabelColor = DynamicColor(UIColor.grayColor(150), UIColor.grayColor(150))
/// Placeholder颜色
let BasePlaceholderColor = DynamicColor(UIColor.grayColor(187), UIColor.grayColor(87))
/// 分割线颜色
let BaselineColor = DynamicColor(UIColor.rgbColor(230, 230, 230), UIColor.grayColor(35))
/// 空数据文字颜色
let BaseEmptyDataTextColor = DynamicColor(BaseLightGreyTextColor, BaseLightGreyTextColor_Dark)
/// 导航条背景色，白底黑字
let BaseNavBgColor = DynamicColor(UIColor.white, BaseBgColor)
/// 导航条标题颜色
let BaseNavTitleColor = DynamicColor(UIColor.black, UIColor.white)
/// 导航条item文字颜色
let BaseNavTextColor = DynamicColor(UIColor.black, UIColor.white)
/// 导航条背景色，主题色白字
let BaseNavBgColor2 = DynamicColor(BaseThemeColor, BaseBgColor)
/// 导航条标题颜色
let BaseNavTitleColor2 = DynamicColor(UIColor.white, UIColor.white)
/// TabBar背景色
let BaseTabBarBgColor = DynamicColor(UIColor.white, UIColor.grayColor(29))
/// TabBar默认文字颜色
let BaseTabBarNormalTextColor = DynamicColor(BaseBlackTextColor, BaseBlackTextColor_Dark)
/// TabBar选中文字颜色
let BaseTabBarSelectTextColor = DynamicColor(BaseThemeColor, BaseThemeColor)
/// Cell背景颜色
let BaseCellBgColor = DynamicColor(UIColor.white, UIColor.grayColor(25))
/// TextView背景颜色
let BaseTextViewBgColor = DynamicColor(UIColor.grayColor(250), UIColor.grayColor(50))
/// Btn、segment等UI组件背景颜色
let BaseBtnBgColor = DynamicColor(BaseThemeColor, UIColor.grayColor(43))
/// Toast 背景颜色
let BaseToastBgColor = DynamicColor(UIColor.white, UIColor.grayColor(47))
/// Alert 背景颜色
let BaseAlertBgColor = DynamicColor(UIColor.white, UIColor.grayColor(44))
/// Picker 背景颜色
let BasePickerBgColor = DynamicColor(UIColor.white, UIColor.grayColor(30))
/// Pop 背景颜色
let BasePopBgColor = DynamicColor(UIColor.white, UIColor.grayColor(64))

// MARK: - 字体设置

/// 设置字体大小
func RD_Font(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

/// 设置粗体字字号
func RD_BoldFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

/// 根据屏幕自适应字体参数 16 * FontFit
let RD_FontFit = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 375

/// 系统默认字体
func RD_SystemFont(_ size: CGFloat) -> UIFont {
    return .systemFont(ofSize: size)
}

/// 系统默认字体
func RD_SystemFontBold(_ size: CGFloat) -> UIFont {
    return .boldSystemFont(ofSize: size)
}

// MARK: - 常用系统字体大小

let RDFont_10 = RD_Font(10)
let RDFont_11 = RD_Font(11)
let RDFont_12 = RD_Font(12)
let RDFont_13 = RD_Font(13)
let RDFont_14 = RD_Font(14)
let RDFont_15 = RD_Font(15)
let RDFont_16 = RD_Font(16)
let RDFont_17 = RD_Font(17)
let RDFont_18 = RD_Font(18)
let RDFont_19 = RD_Font(19)
let RDFont_20 = RD_Font(20)
let RDFont_25 = RD_Font(25)
let RDFont_30 = RD_Font(30)

// MARK: - 常用粗体系统字体大小

let RDBoldFont_10 = RD_BoldFont(10)
let RDBoldFont_11 = RD_BoldFont(11)
let RDBoldFont_12 = RD_BoldFont(12)
let RDBoldFont_13 = RD_BoldFont(13)
let RDBoldFont_14 = RD_BoldFont(14)
let RDBoldFont_15 = RD_BoldFont(15)
let RDBoldFont_16 = RD_BoldFont(16)
let RDBoldFont_17 = RD_BoldFont(17)
let RDBoldFont_18 = RD_BoldFont(18)
let RDBoldFont_19 = RD_BoldFont(19)
let RDBoldFont_20 = RD_BoldFont(20)
let RDBoldFont_25 = RD_BoldFont(25)
let RDBoldFont_30 = RD_BoldFont(30)
