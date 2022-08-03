//
//  RoomsTableViewCell.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 03/08/2022.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {
    
    static let identifier = "RoomsTableViewCell"

    @IBOutlet weak var image_availability: UIImageView!
    @IBOutlet weak var lbl_roomId: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_maxOcc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCellData(data : Rooms){
        self.lbl_roomId.text = data.id ?? ""
        self.lbl_date.text = data.getDate()
        self.lbl_maxOcc.text = "Max: \(data.maxOccupancy ?? 0)"
        self.image_availability.image = data.getImageAvailability()
    }
}
