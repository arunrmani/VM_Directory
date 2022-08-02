//
//  LaunchViewController.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 01/08/2022.
//

import UIKit

class LaunchViewController: UIViewController {

    var launchVM = LaunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindWithViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        launchVM.startLaunchAnimation()
    }


}
extension LaunchViewController{
    private func bindWithViewModel(){
        launchVM.finishLaunchAnimation.bind { stastus in
            if stastus{
                self.performSegue(withIdentifier: SegueID.LaunchToHome, sender: self)
            }
        }
    }
}
