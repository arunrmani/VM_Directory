//
//  ContactListTableViewCell.swift
//  VM Directory
//
//  Created by Arun R Mani on 03/08/2022.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    static let identifier = "ContactListTableViewCell"
    
    @IBOutlet weak var image_avatar: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_jobTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(data : People){
        self.lbl_name.text = data.getFullName()
        self.lbl_jobTitle.text = data.jobtitle ?? ""

        if let imgUrl =  data.avatar{
            self.image_avatar.imageFromServerURL(urlString: imgUrl, PlaceHolderImage: UIImage(named:"sampleContactAvatar")!)
        }
    }
}
