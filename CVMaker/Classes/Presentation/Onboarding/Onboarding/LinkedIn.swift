//
//  LinkedIn.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 09.05.2024.
//

import UIKit
import WebKit

final class LinkedIn: UIViewController {
    private lazy var webView = WKWebView(frame: view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.main100
        
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        startLinkedInAuth()
    }
}

// MARK: WKNavigationDelegate
extension LinkedIn: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.absoluteString.starts(with: GlobalDefinitions.LinkedIn.redirectUri) {
            if let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value {
                print("___ Authorization code: \(code)")
                self.fetchAccessToken(with: code)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
}

// MARK: Private
private extension LinkedIn {
    func startLinkedInAuth() {
        let clientId = GlobalDefinitions.LinkedIn.clientId
        let redirectUri = GlobalDefinitions.LinkedIn.redirectUri
        let scope = "profile"
        let state = UUID().uuidString

        if let authURL = URL(string: "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=\(clientId)&redirect_uri=\(redirectUri)&scope=\(scope)&state=\(state)") {
            let request = URLRequest(url: authURL)
            webView.load(request)
        }
    }

    func fetchAccessToken(with code: String) {
        let url = URL(string: "https://www.linkedin.com/oauth/v2/accessToken")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let params = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": GlobalDefinitions.LinkedIn.redirectUri,
            "client_id": GlobalDefinitions.LinkedIn.clientId,
            "client_secret": GlobalDefinitions.LinkedIn.clientShared
        ]
        let body = params.map { "\($0)=\($1)" }.joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        request.httpBody = body?.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("___ Error fetching access token: \(error!.localizedDescription)")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let accessToken = json["access_token"] as? String {
                    print("___ Access Token: \(accessToken)")
                    // Сохраните токен и используйте его для выполнения API запросов
                    // Например, получение данных профиля
                    self.fetchProfileData(with: accessToken)
                    self.fetchEmailAddress(with: accessToken)
                }
            } catch {
                print("___ JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func fetchProfileData(with accessToken: String) {
        let url = URL(string: "https://api.linkedin.com/v2/me?projection=(firstName,lastName)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("___ Error fetching profile data: \(error!.localizedDescription)")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("___ Profile Data: \(json)")
                }
            } catch {
                print("___ JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func fetchEmailAddress(with accessToken: String) {
        let url = URL(string: "https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("___ Error fetching email data: \(error!.localizedDescription)")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("___ Email Data: \(json)")
                }
            } catch {
                print("___ JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}
