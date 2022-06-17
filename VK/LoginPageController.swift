//
//  ViewController.swift
//  VK
//
//  Created by Aurelica Apps iOS Dev - 1 on 08/03/22.
//

import UIKit
import WebKit
import CloudKit
import FirebaseDatabase

class LoginPageController: UIViewController, UITextFieldDelegate {

    var session = Session.instance  // singleton for storing data about the current session

    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }

//    @IBOutlet weak var scrollView: UIScrollView!
//
//    @IBOutlet weak var myImage: UIImageView!
//
//    @IBOutlet weak var loginText: UITextField!
//    @IBOutlet weak var passwordText: UITextField!
//
//    @IBOutlet weak var myErrorLabel: UILabel!
//    @IBAction func logInButton(_ sender: Any) {
//        let login = loginText.text!
//        // Получаем текст-пароль
//        let password = passwordText.text!
//        // Проверяем, верны ли они
//        if login == "judge0636" && password == "34567" {
//            myErrorLabel.text = "Congratulations"
//        }
//        if login == "" || password == "" {
//            myErrorLabel.text = "Input your login/password"
//            myErrorLabel.textColor = UIColor.red
//        }
//    }
//
//    @objc func keyboardWasShown(notification: Notification) {
//        // Получаем размер клавиатуры
//        let info = notification.userInfo! as NSDictionary
//        let kbSize = (info.value(forKey:
//                                    UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
//        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom:
//                                            kbSize.height, right: 0.0)
//        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
//        scrollView?.contentInset = contentInsets
//        scrollView?.scrollIndicatorInsets = contentInsets
//    }
    

    //Когда клавиатура исчезает
//    @objc func keyboardWillBeHidden(notification: Notification) {
//        // Устанавливаем отступ внизу UIScrollView, равный 0
//        let contentInsets = UIEdgeInsets.zero
//        scrollView?.contentInset = contentInsets
//    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
//
//        NotificationCenter.default.addObserver(self, selector:
//                                                #selector(self.keyboardWasShown), name:
//                                                UIResponder.keyboardWillShowNotification, object: nil)
//        // Второе — когда она пропадает
//        NotificationCenter.default.addObserver(self, selector:
//                                                #selector(self.keyboardWillBeHidden(notification:)), name:
//                                                UIResponder.keyboardWillHideNotification, object: nil)
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name:
//                                                    UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name:
//                                                    UIResponder.keyboardWillHideNotification, object: nil)
//    }

//    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
//        if let identifierr = identifier {
//            if identifierr == "segue" {
//                if loginText.text != "judge0636" && passwordText.text != "34567" {
//                    return false
//                }
//            }
//        }
//        return true
//    }

//    @objc func hideKeyboard() {
//        self.scrollView?.endEditing(true)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAuthVK()


    }

    func loadAuthVK() {
        let configuration = URLSessionConfiguration.default

        let session = URLSession(configuration: configuration)


        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")

        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "7548358"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value:
                            "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]

        guard let url = urlComponents?.url else { return }
        print("kfdfdf")
        print(url)
        let request = URLRequest(url: url)

        webview.load(request)
    }

}

extension LoginPageController: WKNavigationDelegate {

    func write(_ userID: String) {
        let database = Database.database()
        let ref = database.reference()

        // read from Firebase
        ref.observe(.value) { snapshot in
            let users = snapshot.children.compactMap {$0 as? DataSnapshot}
            let keys = users.compactMap {$0.key}
        // check user
            guard keys.contains(userID) == false else {
                ref.removeAllObservers()

                let value = users.compactMap {$0.value}

                print("UserID: \(userID) with value:\(value)")
                return
            }


            ref.child(userID).setValue("")
            print("new user with ID: \(userID)")
        }

    }


    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }

        guard let token = params["access_token"],
        let userID = params["user_id"] else {return}
        Session.instance.token = token
        Session.instance.userID = Int(userID)!
        performSegue(withIdentifier: "showListUsersPhoto", sender: nil)
        decisionHandler(.cancel)

        write(userID)
    }

}
