//
//  LaunchViewModel.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 01/08/2022.
//

import Foundation


class  LaunchViewModel{
    
    var isInterNetAvailable: Observable<Bool> = Observable(false)
    var finishLaunchAnimation: Observable<Bool> = Observable(false)
    var quoteStr: Observable<String> = Observable("")
    var quoteAuthorStr: Observable<String> = Observable("")

    func startLaunchAnimation(){
        self.setQuotes()
    }
    
    func goToNextViewController(){
        finishLaunchAnimation.value = true
    }
    
}

extension LaunchViewModel{
    private func checkInternet(){
    }
    
    private func setQuotes(){
        if let quote = QuotesData.shared.getRandomQuote(){
            quoteStr.value = quote.quote ?? ""
            quoteAuthorStr.value = quote.author ?? ""
        }
    }
    
}
