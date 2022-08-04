//
//  LaunchViewController.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 01/08/2022.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var borderImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var lbl_quotes: UILabel!
    @IBOutlet weak var lbl_quotesAuthor: UILabel!
    @IBOutlet weak var borderImgBarHeight: NSLayoutConstraint!
    @IBOutlet weak var skipViewBarHeight: NSLayoutConstraint!


    var launchVM = LaunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindWithViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        launchVM.startLaunchAnimation()
    }

    @IBAction func skipBtnAction(_ sender: UIButton) {
        launchVM.goToNextViewController()
    }

}
extension LaunchViewController{
    private func bindWithViewModel(){
        launchVM.finishLaunchAnimation.bind {[weak self] stastus in
            if stastus{
                self?.performSegue(withIdentifier: SegueID.LaunchToHome, sender: self)
            }
        }
        launchVM.quoteStr.bind {[weak self] quote in
            self?.lbl_quotes.text  = quote
        }
        launchVM.quoteAuthorStr.bind {[weak self] quotesAuthor in
            self?.lbl_quotesAuthor.text  = quotesAuthor
        }
        launchVM.isNetworkAvailable.bind {[weak self] status in
            if !status{
                self?.showAlert(title: "Network Error", message: "Network Not Available, Please Check Your Internet Connection")
            }
        }
        launchVM.borderImageHeight.bind {[weak self] value in
            UIView.animate(withDuration: 3) {
                self?.borderImgBarHeight.constant = value
                self?.skipViewBarHeight.constant = 107
                self?.view.layoutIfNeeded()
            }
        }
        
        
        
    }
}
