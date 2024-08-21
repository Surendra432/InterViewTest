//
//  ViewController.swift
//  InterviewTest
//
//  Created by Surendra P on 22/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var houseTableView: UITableView!
    private var viewModel = HouseViewModel()
    var houseList:[HouseResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "House List"
        self.houseTableView.delegate = self
        self.houseTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchHouseList()
    }
    
    private func fetchHouseList() {
        viewModel.fetchHouseList { result in
            switch result {
            case .success(let houseList):
                DispatchQueue.main.async {
                    self.houseList = houseList
                    self.houseTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching House List: \(error.localizedDescription)")
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.houseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let houseCell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as! HouseCell
        houseCell.nameLbl.text = "Name: " + self.houseList[indexPath.row].name
        houseCell.regionLbl.text = "Region: " + self.houseList[indexPath.row].region
        return houseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
