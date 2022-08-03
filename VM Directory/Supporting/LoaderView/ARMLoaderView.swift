//
//  EFRLoaderView.swift
//  DocumentReaderSDK
//
//  Created by Safe City Mac 001 on 28/07/2021.
//

import Foundation
import UIKit

internal let ARMLoader = ARMLoaderView.sharedInstance
internal class ARMLoaderView : UIView {
    static let sharedInstance = Bundle(for: ARMLoaderView.self).loadNibNamed("ARMLoaderView", owner: nil)?[0] as! ARMLoaderView
    @IBOutlet weak var LoaderLbl: UILabel!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!

    private var msgText : String = ""{
        didSet{
            LoaderLbl.text = msgText
        }
    }
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func updateConstraints() {
        self.frame = (self.window?.bounds)!
        super.updateConstraints()
    }
    
    
    internal func show(_ msg :String = "Please wait..." ) {
        self.msgText = msg
        let mainWindow: UIWindow? = UIApplication.shared.windows.first
        mainWindow?.addSubview(self)
    }
    internal func show(duration: Double,_ msg :String = "" ) {
        self.msgText = msg
        let mainWindow: UIWindow? = UIApplication.shared.windows.first
        mainWindow?.addSubview(self)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.hide()
        }
    }
    internal func hide(){
        DispatchQueue.main.async {
            if ((self.superview) != nil) {
                self.removeFromSuperview()
            }
        }
        
    }
}
