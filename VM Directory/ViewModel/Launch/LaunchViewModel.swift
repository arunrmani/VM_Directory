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

    func startLaunchAnimation(){
        finishLaunchAnimation.value = true
    }
}
