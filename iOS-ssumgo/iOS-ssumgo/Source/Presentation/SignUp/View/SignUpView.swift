//
//  SignUpView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
@preconcurrency import WebKit

class CustomWebView: WKWebView {
    override var inputAccessoryView: UIView? {
        return nil
    }
}

struct SignUpWebView: UIViewRepresentable {
    let urlString: String
    @Binding var navigateToEmailAuth: Bool
    @Binding var email: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = CustomWebView()
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator

        let script = """
        // JavaScript: 화면 축소 및 버튼 클릭 이벤트 감지
        var meta = document.createElement('meta');
               meta.name = 'viewport';
               meta.content = 'width=device-width, initial-scale=0.8, maximum-scale=5.0, user-scalable=yes';
               document.getElementsByTagName('head')[0].appendChild(meta);
        
        document.addEventListener('DOMContentLoaded', function () {
            const inputFields = document.querySelectorAll('input[type="text"], input[type="email"]');
            inputFields.forEach((input) => {
                input.setAttribute('autocapitalize', 'none');
            });
        });
        
         // 이메일 입력 값 변경 감지
        document.addEventListener('input', function(event) {
            var activeInput = event.target;
            if (activeInput && activeInput.tagName.toLowerCase() === 'input') {
                console.log("Input Field Value: ", activeInput.value); // 디버깅 로그
                window.webkit.messageHandlers.emailHandler.postMessage(activeInput.value.trim());
            }
        });



        // DOM 변경 감지 및 버튼 클릭 이벤트 등록
        const observer = new MutationObserver(() => {
            const buttons = document.querySelectorAll('button');
            buttons.forEach((button) => {
                if (!button.hasAttribute('data-ios-click-handler')) {
                    button.setAttribute('data-ios-click-handler', 'true');
                    if (button.innerText.includes('인증 메일 받기')) {
                        button.addEventListener('click', (event) => {
                            event.preventDefault(); // 기본 동작 차단
                            window.webkit.messageHandlers.buttonClickHandler.postMessage('인증 메일 버튼 클릭');
                        });
                    }
                }
            });
        });

        // 감시 시작
        observer.observe(document.body, { childList: true, subtree: true });

        // 초기 버튼 이벤트 등록
        document.querySelectorAll('button').forEach((button) => {
            if (!button.hasAttribute('data-ios-click-handler')) {
                button.setAttribute('data-ios-click-handler', 'true');
                if (button.innerText.includes('인증 메일 받기')) {
                    button.addEventListener('click', (event) => {
                        event.preventDefault();
                        window.webkit.messageHandlers.buttonClickHandler.postMessage('인증 메일 버튼 클릭');
                    });
                }
            }
        });
        """
        let userScript = WKUserScript(
            source: script,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
        webView.configuration.userContentController.addUserScript(userScript)

        // 핸들러 추가
        webView.configuration.userContentController.add(context.coordinator, name: "buttonClickHandler")
        webView.configuration.userContentController.add(context.coordinator, name: "emailHandler")

        // URL 로드
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
        var parent: SignUpWebView

        init(_ parent: SignUpWebView) {
            self.parent = parent
        }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "buttonClickHandler" {
                DispatchQueue.main.async {
                    self.parent.navigateToEmailAuth = true
                }
            } else if message.name == "emailHandler", let emailValue = message.body as? String {
                DispatchQueue.main.async {
                    self.parent.email = emailValue
                }
            } else {
                print("Unhandled message: \(message.name)")
            }

        }

        // 외부 URL 오픈
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }
            
            if navigationAction.navigationType == .linkActivated {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
            
            decisionHandler(.allow)
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if let url = navigationAction.request.url {
                UIApplication.shared.open(url)
            }
            return nil
        }
    }
}

struct SignUpView: View {
    @State private var backButton = false
    @State private var navigateToEmailAuth = false
    @State private var navigateToBack = false
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            BackNavigationBar(
                rightIcon: false,
                title: "",
                onLeftIconTap: {
                    navigateToBack = true
                }
            )
            
            VStack {
                SignUpWebView(
                    urlString: "\(Config.signupWebURL)",
                    navigateToEmailAuth: $navigateToEmailAuth,
                    email: $email
                )
                
            }
            .navigationDestination(isPresented: $navigateToEmailAuth) {
                EmailAuthView(email: "\(email)@soongsil.ac.kr")
            }
            .navigationDestination(isPresented: $navigateToBack) {
                LoginView()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SignUpView()
}
