//
//  MainViewController.swift
//  TestVPN
//
//  Created by MacBook on 2.03.21.
//

import UIKit

protocol MainControllerDelegate: class {
    func update(image: UIImage)
}

class MainViewController: UIViewController, MainControllerDelegate {
    
    
    let contenerView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let menuView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let menuButton: UIButton = {
       let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let connectButton: UIButton = {
        let bt = UIButton()
        bt.layer.cornerRadius = 20
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let iconImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    var tableView: UITableView!
    
    var timer: Timer?
    var isMove: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentView()
        configureMenuView()
        configureTableView()
//        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseId)
        menuView.addSubview(tableView)
        tableView.frame = view.frame
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.backgroundColor = .white
    }
    
    func configureMenuView() {
        view.insertSubview(menuView, at: 0)
        menuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func configureContentView() {
        view.addSubview(contenerView)
        contenerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contenerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contenerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contenerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        let imageMenu = UIImage(named: "menu")
        menuButton.setImage(imageMenu, for: .normal)
        menuButton.setImage(imageMenu, for: .normal)
        contenerView.addSubview(menuButton)
        menuButton.topAnchor.constraint(equalTo: contenerView.topAnchor, constant: 30).isActive = true
        menuButton.leadingAnchor.constraint(equalTo: contenerView.leadingAnchor, constant: 10).isActive = true
        menuButton.addTarget(self, action: #selector(menuButtonTap(_:)), for: .touchUpInside)
        
        contenerView.addSubview(connectButton)
        connectButton.centerXAnchor.constraint(equalTo: contenerView.centerXAnchor).isActive = true
        connectButton.centerYAnchor.constraint(equalTo: contenerView.centerYAnchor).isActive = true
        connectButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        connectButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        connectButton.setTitle("Connect", for: .normal)
        connectButton.setTitleColor(.black, for: .normal)
        connectButton.backgroundColor = .systemGray4
        connectButton.addTarget(self, action: #selector(connectButtonTap(_:)), for: .touchUpInside)
        
        contenerView.addSubview(iconImageView)
        iconImageView.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: -20).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: connectButton.centerXAnchor).isActive = true
    }
    
    @objc func menuButtonTap(_ sender: UIButton){
        isMove = !isMove
        showMenuVC(shouldMove: isMove)
    }
    
    @objc func connectButtonTap(_ sender: UIButton){
        var counter = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in
            self.animationScaleEffect(view: sender)
            counter += 1
            if counter == 10 {
                sender.layer.removeAllAnimations()
                timer.invalidate()
            }
        })
    }
    
    func animationScaleEffect(view:UIView)
    {
            let pulseAnimation = CABasicAnimation(keyPath: "backgroundColor")
            pulseAnimation.duration = 1
            pulseAnimation.fromValue = UIColor.red.cgColor
            pulseAnimation.toValue = UIColor.blue.cgColor
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = .greatestFiniteMagnitude
            view.layer.add(pulseAnimation, forKey: nil)
    }
    

    func showMenuVC(shouldMove: Bool) {
        if shouldMove {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.contenerView.frame.origin.x = self.contenerView.frame.width/2.5
            }) { (finished) in
            }
        } else {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.contenerView.frame.origin.x = 0
            }) { (finished) in
            }
        }
    }
    
    func update(image: UIImage) {
        iconImageView.image = image
    }

}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseId) as! MenuTableViewCell
        let menuModel = MenuModel(rawValue: indexPath.row)
        cell.iconImageView.image = menuModel?.image
        cell.myLabel.text = menuModel?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let countryVC = CountriesViewController()
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.contenerView.frame.origin.x = 0
        }) { (finished) in
        }
        countryVC.delegate = self
        self.navigationController?.pushViewController(countryVC, animated: true)
    }
}
