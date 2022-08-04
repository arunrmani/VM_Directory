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
    
    @IBOutlet weak var btn_search: UIButton!
    @IBOutlet weak var view_search: UIView!

    
    var homeVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        self.bindviewModel()
        self.homeVM.selectListType(type: .contacts)
    }
    
    @IBAction func menuBtnPress(_ sender: UIButton) {
        
    }
    @IBAction func searchBtnPress(_ sender: UIButton) {
        self.homeVM.searchBtnPress()
    }
    @IBAction func contactBtnPress(_ sender: UIButton) {
        self.homeVM.selectListType(type: .contacts)
    }
    @IBAction func roomBtnPress(_ sender: UIButton) {
        self.homeVM.selectListType(type: .rooms)
    }
    
        // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactDetailsViewController{
            destination.detailsVM = ContactDetailsViewModel(selectedContact: self.homeVM.selectedContact.value)
        }
        
    }
    
}
    // MARK: - VM Binding

extension HomeViewController{
    private func bindviewModel(){
        self.homeVM.contactList.bind {[weak self] dataList in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
        }
        self.homeVM.roomsList.bind {[weak self] dataList in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
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
        
        self.homeVM.selectedType.bind {[weak self] type in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        self.homeVM.searchBarHeight.bind {[weak self] height in
            DispatchQueue.main.async {
                self?.searchBarHeight.constant = height
                self?.view_search.isHidden = height == 0
            }
        }
        self.homeVM.searchBtnImage.bind {[weak self] img in
            DispatchQueue.main.async {
                self?.btn_search.setImage(img, for: .normal)
            }
        }
        
        self.homeVM.searchText.bind {[weak self] searchText in
            DispatchQueue.main.async {
                self?.txt_search.text = searchText
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
                cell.selectionStyle = .none
                if let contactData = self.homeVM.getContact(at: indexPath.row){
                    cell.setCellData(data: contactData)
                }
                return cell
            case .rooms:
                let cell = tableView.dequeueReusableCell(withIdentifier: RoomsTableViewCell.identifier, for: indexPath) as! RoomsTableViewCell
                cell.selectionStyle = .none
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

// MARK: - TextFieldDelegate

extension HomeViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        var searchText  = textField.text! + string
        
        if string  == "" {
            searchText = (searchText as String).substring(to: searchText.index(before: searchText.endIndex))
        }
        self.homeVM.searchStringAction(str: searchText)
        
        return true
    }

    
}
