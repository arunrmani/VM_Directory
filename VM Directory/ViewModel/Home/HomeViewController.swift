    //
    //  HomeViewController.swift
    //  VM Directory
    //
    //  Created by Safe City Mac 001 on 01/08/2022.
    //

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var homeVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindviewModel()
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
        self.homeVM.goTodetails.bind { status in
            if status{
                self.performSegue(withIdentifier: SegueID.HomeToContactDetails, sender: self)
            }
        }
    }
}

    // MARK: - TableViewDelegates

extension HomeViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.contactListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.homeVM.selectContact(index: indexPath.row)
    }
    
}
