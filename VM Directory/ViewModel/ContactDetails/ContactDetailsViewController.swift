    //
    //  ContactDetailsViewController.swift
    //  VM Directory
    //
    //  Created by Safe City Mac 001 on 02/08/2022.
    //

import UIKit
import MessageUI

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
        self.img_avatar.rotate(angle: -3)
    }
    
    @IBAction func closebtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func menuBtnPress(_ sender: UIButton) {
        
    }
    @IBAction func sentMailBtnPress(_ sender: UIButton) {
        self.sendEmail()
    }
    
}

extension ContactDetailsViewController{
    private func bindViewModel(){
        self.detailsVM?.selectedContact.bind {[weak self] contact in
            DispatchQueue.main.async {
                self?.lbl_firstName.text = contact?.firstName
                self?.lbl_lastName.text = contact?.lastName
                self?.lbl_jobTitle.text = contact?.jobtitle
                self?.lbl_email.text = contact?.email
                self?.lbl_favcolor.text = contact?.favouriteColor
                if let imgUrl =  contact?.avatar{
                    self?.img_avatar.imageFromServerURL(urlString: imgUrl, PlaceHolderImage: UIImage(named:"sampleContactAvatar")!)
                }
            }
        }
    }
}


    // MARK: - Sent Mail
extension ContactDetailsViewController : MFMailComposeViewControllerDelegate{
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([self.detailsVM?.selectedContact.value?.email ?? ""])
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true)
        } else {
            self.showAlert(title: "Error", message: "Something went wrong!!!")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
