    //
    //  HomeViewController.swift
    //  VM Directory
    //
    //  Created by Safe City Mac 001 on 01/08/2022.
    //

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    @IBOutlet weak var txt_search: UITextField!
    
    @IBOutlet weak var view_Contact: UIView!
    @IBOutlet weak var lbl_Contact: UILabel!
    @IBOutlet weak var view_Room: UIView!
    @IBOutlet weak var lbl_Room: UILabel!
    
    
    
    var homeVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindviewModel()
        self.homeVM.selectListType(type: .contacts)
    }
    
    @IBAction func menuBtnPress(_ sender: UIButton) {
        
    }
    @IBAction func searchBtnPress(_ sender: UIButton) {
        
    }
    @IBAction func contactBtnPress(_ sender: UIButton) {
        self.homeVM.selectListType(type: .contacts)
    }
    @IBAction func roomBtnPress(_ sender: UIButton) {
        self.homeVM.selectListType(type: .rooms)
    }
    
}
    // MARK: - VM Binding

extension HomeViewController{
    private func bindviewModel(){
        self.homeVM.contactList.bind {[unowned self] dataList in
            if dataList.count > 0{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        self.homeVM.roomsList.bind {[unowned self] dataList in
            if dataList.count > 0{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        self.homeVM.goTodetails.bind { status in
            if status{
                self.performSegue(withIdentifier: SegueID.HomeToContactDetails, sender: self)
            }
        }
        
        self.homeVM.contactBgColor.bind {[weak self] color in
            DispatchQueue.main.async {
                
                self?.view_Contact.backgroundColor = color
            }
        }
        self.homeVM.contactTitleColor.bind {[weak self] color in
            DispatchQueue.main.async {
                self?.lbl_Contact.textColor = color
            }
        }
        self.homeVM.roomBgColor.bind {[weak self] color in
            DispatchQueue.main.async {
                
                self?.view_Room.backgroundColor = color
            }
        }
        self.homeVM.roomTitleColor.bind {[weak self] color in
            DispatchQueue.main.async {
                self?.lbl_Room.textColor = color
            }
        }
        
        self.homeVM.selectedType.bind { type in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
}

    // MARK: - TableViewDelegates

extension HomeViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeVM.selectedType.value == .contacts ? homeVM.contactListCount : homeVM.roomsListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.homeVM.selectedType.value{
            case .contacts:
                let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.identifier, for: indexPath) as! ContactListTableViewCell
                if let contactData = self.homeVM.getContact(at: indexPath.row){
                    cell.setCellData(data: contactData)
                }
                return cell
            case .rooms:
                let cell = tableView.dequeueReusableCell(withIdentifier: RoomsTableViewCell.identifier, for: indexPath) as! RoomsTableViewCell
                if let roomData = self.homeVM.getRoom(at: indexPath.row){
                    cell.setCellData(data: roomData)
                }
                return cell
            case .none:
                let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.identifier, for: indexPath) as! ContactListTableViewCell
                if let contactData = self.homeVM.getContact(at: indexPath.row){
                    cell.setCellData(data: contactData)
                }
                return cell
                
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch self.homeVM.selectedType.value{
            case .contacts:
                self.homeVM.selectContact(index: indexPath.row)
            case .rooms:
                print("Room Selected")
            case .none:
                print("none")

        }
    }
    
}
