//
//  ViewController.swift
//  FirebaseJSON
//
//  Created by Kevinho Morales on 16/12/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var data = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // HACER LA LLAMADA AL SERVER
        let networkManager = NetworkManager(delegate: self)
        networkManager.downloadDataFromAPI()
    }
    //
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = data[indexPath.row].documents[0].fields.from.stringValue
        cell.detailTextLabel?.text = data[indexPath.row].documents[0].fields.to.stringValue
        return cell
    }
}

extension ViewController: NetworkManagerDataResource {
    func getDataFromServer(data: [Users]) {
        self.data = data
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
        }
    }
}
