//
//  Utility.swift
//  CollectionApp
//
//  Created by MACBOOK on 17/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation
import SDWebImage
import Toast_Swift
import SafariServices
import Foundation
import EventKit
import MapKit
import SKPhotoBrowser

extension UIView {
    //MARK: - addBorderColorWithCornerRadius
    func addBorderColorWithCornerRadius(borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}

//MARK:- toJson
func toJson(_ dict:[String:Any]) -> String{
    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let jsonString = String(data: jsonData!, encoding: .utf8)
    return jsonString!
}

//MARK: - getCurrentTimeStampValue
func getCurrentTimeStampValue() -> String
{
    return String(format: "%0.0f", Date().timeIntervalSince1970*1000)
}

//MARK: - DataExtension
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }

}

//MARK:- Delay Features
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

//MARK:- Toast
func displayToast(_ message:String)
{
    UIApplication.topViewController()?.view.makeToast(getTranslate(message))
}


func displayToastWithDelay(_ message:String)
{
    delay(0.2) {
        UIApplication.topViewController()?.view.makeToast(getTranslate(message))
    }
}

func printData(_ items: Any..., separator: String = " ", terminator: String = "\n")
{
    #if DEBUG
        items.forEach {
            Swift.print($0, separator: separator, terminator: terminator)
        }
    #endif
}

//MARK:- Image Function
func compressImageView(_ image: UIImage, to toSize: CGSize) -> UIImage {
    var actualHeight: Float = Float(image.size.height)
    var actualWidth: Float = Float(image.size.width)
    let maxHeight: Float = Float(toSize.height)
    //600.0;
    let maxWidth: Float = Float(toSize.width)
    //800.0;
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    //50 percent compression
    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }
    let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    let imageData1: Data? = img?.jpegData(compressionQuality: 1.0)//UIImageJPEGRepresentation(img!, CGFloat(1.0))//UIImage.jpegData(img!)
    UIGraphicsEndImageContext()
    return  imageData1 == nil ? image : UIImage(data: imageData1!)!
}

//Image Compression to 10th
func compressImage(image: UIImage) -> Data {
    // Reducing file size to a 10th
    var actualHeight : CGFloat = image.size.height
    var actualWidth : CGFloat = image.size.width
    let maxHeight : CGFloat = 1920.0
    let maxWidth : CGFloat = 1080.0
    var imgRatio : CGFloat = actualWidth/actualHeight
    let maxRatio : CGFloat = maxWidth/maxHeight
    var compressionQuality : CGFloat = 0.5
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if (imgRatio < maxRatio) {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        } else if (imgRatio > maxRatio) {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        } else {
            actualHeight = maxHeight
            actualWidth = maxWidth
            compressionQuality = 1
        }
    }
    let rect = CGRect(x: 0.0, y: 0.0, width:actualWidth, height:actualHeight)
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    let imageData = img!.jpegData(compressionQuality: compressionQuality)
    UIGraphicsEndImageContext();
    return imageData!
}

//MARK: - downloadCachedImage
extension UIImageView{
    func downloadCachedImage(placeholder: String,urlString: String){
        let options: SDWebImageOptions = [.scaleDownLargeImages, .continueInBackground, .avoidAutoSetImage]
        let placeholder = UIImage(named: placeholder)
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: options) { (image, _, cacheType,_ ) in
            //self.sainiRemoveLoader()
            guard image != nil else {
                //self.sainiRemoveLoader()
                return
            }
            guard cacheType != .memory, cacheType != .disk else {
                self.image = image
                //self.sainiRemoveLoader()
                return
            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                //self.sainiRemoveLoader()
                self.image = image
                return
            }, completion: nil)
        }
    }
    
    func downloadImage(placeholder: String,urlString: String){
        let options: SDWebImageOptions = [.scaleDownLargeImages, .continueInBackground, .avoidAutoSetImage]
        let placeholder = UIImage(named: placeholder)
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: options) { (image, _, cacheType,_ ) in
            //self.sainiRemoveLoader()
            guard image != nil else {
                //self.sainiRemoveLoader()
                return
            }
            guard cacheType != .memory, cacheType != .disk else {
                self.image = image
                //self.sainiRemoveLoader()
                return
            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                //self.sainiRemoveLoader()
                self.image = image
                return
            }, completion: nil)
        }
    }
}

//MARK: - displaySubViewtoParentView
func displaySubViewtoParentView(_ parentview: UIView! , subview: UIView!)
{
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    parentview.layoutIfNeeded()
}

func getTranslate(_ str : String) -> String
{
    return NSLocalizedString(str, comment: "")
}

//MARK:- Color function
func colorFromHex(hex : String) -> UIColor
{
    return colorWithHexString(hex, alpha: 1.0)
}

func colorFromHex(hex : String, alpha:CGFloat) -> UIColor
{
    return colorWithHexString(hex, alpha: alpha)
}

func colorWithHexString(_ stringToConvert:String, alpha:CGFloat) -> UIColor {
    
    var cString:String = stringToConvert.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

//MARK:- UICollectionView
extension UICollectionView {
   //MARK:- setEmptyMessage
   public func sainiSetEmptyMessageCV(_ message: String) {
       let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
       messageLabel.text = message
       messageLabel.textColor = .black
       messageLabel.numberOfLines = 0;
       messageLabel.textAlignment = .center;
       messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
       messageLabel.sizeToFit()
       self.backgroundView = messageLabel;
    
   }
   //MARK:- sainiRestore
   public func restore() {
       self.backgroundView = nil
       
   }
}

func getBeforeTimeInMinute(_ index: Int) -> Int {
    switch index {
    case 0:
        return 5
    case 1:
        return 10
    case 2:
        return 15
    case 3:
        return 30
    case 4:
        return 60
    case 5:
        return 1440
    default:
        return 0
    }
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            printData(error.localizedDescription)
        }
    }
    return nil
}

//MARK:- Get Json from file
func getJsonFromFile(_ file : String) -> [[String : Any]]
{
    if let filePath = Bundle.main.path(forResource: file, ofType: "json"), let data = NSData(contentsOfFile: filePath) {
        do {
            if let json : [[String : Any]] = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String : Any]] {
                return json
            }
        }
        catch {
            //Handle error
        }
    }
    return [[String : Any]]()
}

// MARK: - getCompleteString
func getCompleteString(strArr: [String]) -> String {
    var str: String = String()
    for i in 0..<strArr.count {
        if i == strArr.count - 1 {
            str += strArr[i]
        }
        else {
            str += (strArr[i]) + ", "
        }
    }
    return str
}

//MARK: - Add event in to default calender
//Give info.plist permission "Privacy - Calendars Usage Description"
//import EventKit
func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, url: String, beforTime: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
    DispatchQueue.global(qos: .background).async { () -> Void in
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                if url != "" {
                    event.url = URL(string: url)
                }
                event.calendar = eventStore.defaultCalendarForNewEvents
                
//                let maxDate : Date = Calendar.current.date(byAdding: .minute, value: -getBeforeTimeInMinute(beforTime), to: startDate)!
                event.alarms = [EKAlarm.init(absoluteDate: beforTime)]
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
//                    printData("failed to save event with error : \(error)")
                    completion?(false, e)
                    return
                }
                printData("Saved Event")
                completion?(true, nil)
            } else {
//                printData("failed to save event with error : \(error) or access not granted")
                completion?(false, error as NSError?)
            }
        })
    }
}


//MARK:- Open Url
func openUrlInSafari(strUrl : String)
{
    if strUrl.trimmed == "" {
        return
    }
    var newStrUrl = strUrl
    if !newStrUrl.contains("http://") && !newStrUrl.contains("https://") {
        newStrUrl = "http://" + strUrl
    }
    if let url = URL(string: newStrUrl) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                UIApplication.topViewController()!.present(vc, animated: true)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.open(url, options: [:]) { (isOpen) in
                    printData(isOpen)
                }
            }
        }
    }
}

//Get year array
func getYearArr() -> [String] {
    var yearArr : [String] = [String]()
    for i in 0...30 {
        let fromDate = Calendar.current.date(byAdding: .year, value: i, to: Date())!
        yearArr.append(getLocalStringFromUTCDate(fromDate, DATE_FORMATE.YEAR.rawValue))
    }
    return yearArr
}

class L102Language {
/// get current Apple language
    class func currentAppleLanguage() -> String
    {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        if current == "" {
            return "en"
        }
        return current
    }
    
    // set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
    class var isRTL: Bool {
        return L102Language.currentAppleLanguage() == "ar"
    }
}

//MARK:- Email
func redirectToEmail(_ email : String)
{
    if email == "" || !email.isValidUrl {
        displayToast("Invalid email address")
        return
    }
    guard let url = URL(string: "mailto:\(email)") else {
        displayToast("Invalid email address")
        return
    }
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url)
    } else {
        UIApplication.shared.openURL(url)
    }
}

func getDoubleValueOfDistance(_ price : Double) -> String {
    return "\(String(format: "%.1f", price))km"
}

func getLabelArray(_ label : [String]) -> String {
    return label.joined(separator: ", ")
}

func isLocationAccessEnabled() -> Bool {
    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            printData("Access")
            return true
        default:
            break
        }
    } else {
        printData("Location services not enabled")
        return false
    }
    return false
}

func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double, _ completion: @escaping (_ value: String) -> Void) {
    if pdblLatitude == 0.0 && pdblLongitude == 0.0 {
        completion("")
        return
    }
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
    let ceo: CLGeocoder = CLGeocoder()
    center.latitude = pdblLatitude
    center.longitude = pdblLongitude
    var addressString : String = ""
    
    let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

    ceo.reverseGeocodeLocation(loc, completionHandler:
        {(placemarks, error) in
            if (error != nil)
            {
                printData("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]

            if pm.count > 0 {
                let pm = placemarks![0]
                if pm.locality != nil {
                    addressString = pm.locality!
                }
                printData(addressString)
                completion(addressString)
          }
    })
}

//MARK:- Attribute string
func attributedStringWithColor(_ mainString : String, _ strings: [String], color: UIColor, font: UIFont? = nil, isUnderLine: Bool = false) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: mainString)
    for string in strings {
        let range = (mainString as NSString).range(of: string)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        if font != nil {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font!, range: range)
        }
        if isUnderLine {
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            attributedString.addAttribute(.underlineColor, value: color, range: range)
        }
    }
    return attributedString
}

extension Encodable {
    //MARK:-  Converting object to postable JSON
    public func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        guard let data = try? encoder.encode(self) else { return [:] }
        guard let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        guard let json = object as? [String: Any] else { return [:] }
        return json
    }
}

extension Data {
    //MARK:- Convert Data into pretty json format
    public var sainiPrettyJSON: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

func displayFlotingValue(_ value : Double) -> String {
    var finalValue = String(format: "%.2f", Float(value))
    if finalValue.contains(".00") {
        finalValue = finalValue.replacingOccurrences(of: ".00", with: "")
        return finalValue
    }
    return finalValue
}

func displayFlotingStar(_ price : Double) -> String
{
    var finalValue = String(format: "%.1f", Float(price))
    if finalValue.contains(".0") {
        finalValue = finalValue.replacingOccurrences(of: ".0", with: "")
    }
    return finalValue
}
    
func displayPriceWithCurrency(_ value : Double) -> String {
    return CURRENCY + " " + displayFlotingValue(value)
}

////MARK : - SKPhotoBrowser
func displayFullImage(_ photos : [String],_ index : Int)
{
    // 1. create URL Array
    var images = [SKPhoto]()
    for i in 0..<photos.count
    {
        let photo = SKPhoto.photoWithImageURL(photos[i])
        photo.shouldCachePhotoURLImage = true // you can use image cache by true(NSCache)
        images.append(photo)
    }
    
    // 2. create PhotoBrowser Instance, and present.
    let browser = SKPhotoBrowser(photos: images)
    browser.initializePageIndex(index)
    UIApplication.topViewController()?.present(browser, animated: true, completion: {})
}
