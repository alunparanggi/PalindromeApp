//
//  Extensions.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 20/10/22.
//

import UIKit
import SkeletonView
import Alamofire
import RxSwift
import SwiftyJSON

extension String {
    func isPalindrome() -> Bool {
        if count < 2 { return false }
        let str = lowercased().replacingOccurrences(of: " ", with: "")
        let strArray = Array(str)
        var i = 0
        var j = strArray.count-1
        while i <= j {
            if strArray[i] != strArray[j] { return false }
            i+=1
            j-=1
        }
        return true
    }
}

extension UIViewController {
    func navigateTo(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureNavigationBar(backgoundColor: UIColor = .white, title: String, titleColor: UIColor = .black) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = backgoundColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.isTranslucent = false
        
        let leftLabel = UILabel()
        leftLabel.textColor = titleColor
        leftLabel.text = title
        leftLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftLabel)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .strongBlue
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    static let strongBlue: UIColor = UIColor(hex: 0x554AF0)
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        showAnimatedGradientSkeleton()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                self?.hideSkeleton()
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension Observable {
    func mapJSONResponse() -> Observable<APIResponse> {
        
        var message: String = ""
        var status: Int = 200
        var result: JSON = JSON()
        
        return map { (item) -> APIResponse in
            guard let json = item as? JSON else {
                fatalError("NOT A JSON!")
            }
            
            result = json
            
            //  MARK: IF CODE EXIST, THEN EXPECTING ERROR HAPPENED
            if json["code"].exists(), let code = json["code"].int, let msg = json["message"].string {
                status = code
                message = msg
            }
            
            //  MARK: IF STATUS EXIST, THEN EXPECTING NO ERROR HAPPENED
            if json["status"].exists(), let code = json["status"].int, let msg = json["msg"].string {
                status = code
                message = msg
                result = json
            }
            return APIResponse(code: status, message: message, result: result)
        }
    }
}

extension DataRequest {
    func rx_JSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<JSON> {
        let observable = Observable<JSON>.create { observer in
            if let method = self.request?.httpMethod, let urlString = self.request?.url {
                print("[\(method)] \(urlString)")
                if let body = self.request?.httpBody {
                    print(NSString(data: body, encoding: String.Encoding.utf8.rawValue) as Any)
                }
            }
            
            self.responseJSON(options: options) { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    observer.onNext(json)
                case .failure(let error):
                    if let afError = error as AFError? {
                        switch afError {
                        case .responseValidationFailed(let reason):
                            observer.onError(self.extractErrorMessage(reason: reason))
                        default:
                            print("")
                        }
                    }
                }
            }
            return Disposables.create()
        }
        return Observable.deferred { return observable }
    }
    
    public func customValidation() -> Self {
        return validate{ request, response, data in
            let success = 200...299
            guard let jsonData = data else {
                return .failure(CustomError.unexpected(message: "Terjadi Kesalahan"))
            }
            let json = JSON(jsonData)
            if success.contains(response.statusCode) {
                return .success(())
            } else {
                if json["message"].exists() {
                    return .failure(CustomError.expected(message: json["message"].string ?? ""))
                } else {
                    return .failure(CustomError.unexpected(message: "Terjadi Kesalahan"))
                }
            }
        }
    }
    
    private func extractErrorMessage(reason: AFError.ResponseValidationFailureReason) -> Error {
        switch reason {
        case .customValidationFailed(let error):
            return error
        default:
            return CustomError.expected(message: "There is something wrong")
        }
    }
}
