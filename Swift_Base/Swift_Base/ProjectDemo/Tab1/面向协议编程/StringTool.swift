//
//  StringTool.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/12.
//

import Foundation
// String,NSString,NSMUtaleString都遵守 ExpressibleByStringLiteral协议
extension WS where Base: ExpressibleByStringLiteral{
    func strTest() -> String{
        var string = base as! String
        return string + "type"
    }
}
extension WS where Base == String {
    func substring(location index:Int, length:Int) -> String {
        if base.count > index {
            let startIndex = base.index(base.startIndex, offsetBy: index)
            let endIndex = base.index(base.startIndex, offsetBy: index + length)
            let subString = base[startIndex..<endIndex]
            return String(subString)
        } else {
            return base
        }
    }
    
    func substring(range:NSRange) -> String {
        if base.count > range.location {
            let startIndex = base.index(base.startIndex, offsetBy: range.location)
            let endIndex = base.index(base.startIndex, offsetBy: range.location + range.length)
            let subString = base[startIndex..<endIndex]
            return String(subString)
        } else {
            return base
        }
    }
        
    func urlScheme(scheme:String) -> URL? {
        if let url = URL.init(string: base) {
            var components = URLComponents.init(url: url, resolvingAgainstBaseURL: false)
            components?.scheme = scheme
            return components?.url
        }
        return nil
    }
    
    static func readJson2DicWithFileName(fileName:String) -> [String:Any] {
        let path = Bundle.main.path(forResource: fileName, ofType: "json") ?? ""
        var dict = [String:Any]()
        do{
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path))
            dict = try JSONSerialization.jsonObject(with: data, options:[]) as! [String : Any]
        }catch {
            print(error.localizedDescription)
        }
        return dict
    }
    
    static func format(decimal:Float, _ maximumDigits:Int = 1, _ minimumDigits:Int = 1) ->String? {
        let number = NSNumber(value: decimal)
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumDigits //设置小数点后最多2位
        numberFormatter.minimumFractionDigits = minimumDigits //设置小数点后最少2位（不足补0）
        return numberFormatter.string(from: number)
    }
}
//#import <CommonCrypto/CommonDigest.h>
extension String {
    func md5() -> String {
        let cStrl = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }

//    static func formatCount(count:NSInteger) -> String {
//        if count < 10000  {
//            return String.init(count)
//        } else {
//            return (String.format(decimal: Float(count)/Float(10000)) ?? "0") + "w"
//        }
//    }
//
//    func singleLineSizeWithText(font:UIFont) -> CGSize {
//        return base.size(withAttributes: [NSAttributedString.Key.font : font])
//    }
//
//    func singleLineSizeWithAttributeText(font:UIFont) -> CGSize {
//        let attributes = [NSAttributedString.Key.font:font]
//        let attString = NSAttributedString(string: base,attributes: attributes)
//        let framesetter = CTFramesetterCreateWithAttributedString(attString)
//        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude), nil)
//    }

}
