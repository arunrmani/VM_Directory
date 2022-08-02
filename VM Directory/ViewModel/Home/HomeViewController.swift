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

    }
    


}
// MARK: - VM

extension HomeViewController{
    private func bindviewModel(){
        
    }
}

// MARK: - TableViewDelegates

extension HomeViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
