//
//  CountriesViewController.swift
//  TestVPN
//
//  Created by MacBook on 2.03.21.
//

import UIKit

class CountriesViewController: UIViewController {

    weak var delegate: MainControllerDelegate?
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
    }
    
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableCell.self, forCellReuseIdentifier: CountryTableCell.reuseId)
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.backgroundColor = .white
    }
}


extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableCell.reuseId) as! CountryTableCell
        let countryModel = CountryModel(rawValue: indexPath.row)
        cell.iconImageView.image = countryModel?.image
        cell.myLabel.text = countryModel?.description
        cell.iconImageView.layer.cornerRadius = (cell.iconImageView.frame.height)/2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.update(image: CountryModel(rawValue: indexPath.row)!.image)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
