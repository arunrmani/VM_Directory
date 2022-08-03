//
//  ContactDetailsViewController.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 02/08/2022.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    @IBOutlet weak var lbl_firstName: UILabel!
    @IBOutlet weak var lbl_lastName: UILabel!
    
    @IBOutlet weak var lbl_jobTitle: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_favcolor: UILabel!
    @IBOutlet weak var img_avatar: UIImageView!
    
    var detailsVM : ContactDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()

    }
    
    @IBAction func closebtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func menuBtnPress(_ sender: UIButton) {
        
    }
   

}


extension ContactDetailsViewController{
    private func bindViewModel(){
        
    }
}
