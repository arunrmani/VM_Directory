//
//  LaunchViewModel.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 01/08/2022.
//

import Foundation
import UIKit


class  LaunchViewModel{
    
    var finishLaunchAnimation: Observable<Bool> = Observable(false)
    var quoteStr: Observable<String> = Observable("")
    var quoteAuthorStr: Observable<String> = Observable("")
    var isNetworkAvailable: Observable<Bool> = Observable(true)
    var borderImageHeight: Observable<Double> = Observable(0.0)

    private var readyToShowHomePage = false

    func startLaunchAnimation(){
        self.checkInternet()
        self.setQuotes()
        self.borderImageHeight.value = UIScreen.main.bounds.height
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            if !self.finishLaunchAnimation.value{
                self.finishLaunchAnimation.value = self.readyToShowHomePage
            }
        })
        
    }
    
    func goToNextViewController(){
        finishLaunchAnimation.value = readyToShowHomePage
    }
    
}

extension LaunchViewModel{
    private func checkInternet(){
        switch Network.reachability.status {
            case .unreachable:
                self.readyToShowHomePage = false
                self.isNetworkAvailable.value  = false
            case .wwan:
                self.readyToShowHomePage = true
            case .wifi:
                self.readyToShowHomePage = true
        }
    }
    
    private func setQuotes(){
        if let quote = QuotesData.shared.getRandomQuote(){
            quoteStr.value = quote.quote ?? ""
            quoteAuthorStr.value = quote.author ?? ""
        }
    }
    
}
