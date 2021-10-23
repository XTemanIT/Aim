//
//  WebViewController.swift
//  Aim
//
//  Created by Artem Sierokurov on 21.10.2021.
//

import UIKit
import SpriteKit
import GameplayKit
import WebKit

class WebViewController: UIViewController{

    var winner:Bool = false
    var webView: WKWebView!
    var myURL = ""
    
    override func loadView() {
        let webConf = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConf)
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Service.sharedInst.getData(from: url)
        NotificationCenter.default.addObserver(self, selector: #selector(Get), name: Notification.Name("Get"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WoL), name: Notification.Name("WoL"), object: nil)
    }
    @objc func Get(notification: Notification){
        guard let userInfo = notification.userInfo else {return}
        guard let textW = userInfo["winner"] as? String else {return}
        guard let textL = userInfo["loser"] as? String else {return}
        //............
    }
    @objc func WoL(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let text = userInfo["winner"] as? String else {return}
        if text == "true" {
            myURL = "https://www.google.com.ua/"
        } else { myURL = "https://www.youtube.com/" }
        let myURL = URL(string: myURL)!
        let request = URLRequest(url: myURL)
        webView.load(request)
    }
}


