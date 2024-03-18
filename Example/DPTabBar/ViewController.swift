//
//  ViewController.swift
//  DPTabBar
//
//  Created by Dipak Panchasara on 03/18/2024.
//  Copyright (c) 2024 Dipak Panchasara. All rights reserved.
//
import UIKit
import DPTabBar

struct Menu {
    let title: String
    let shape: Shape
}

class ViewController: UIViewController {

    @IBOutlet weak var tblCustome: UITableView!
    var arrMenu: [Menu]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        self.arrMenu = [Menu(title: "Full Shape TabBar", shape: Shape.full),
                        Menu(title: "Lower Round Shape TabBar", shape: Shape.lowerRound),
                        Menu(title: "Upper Round Shape TabBar", shape: Shape.upperRound),
                        Menu(title: "Floating TabBar", shape: Shape.floating)]
        self.tblCustome.dataSource = self
        self.tblCustome.delegate = self
        self.tblCustome.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let obj = self.arrMenu[indexPath.row]
        cell.lblTitle.text = obj.title
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.arrMenu[indexPath.row]
        switch obj.shape {
            
        case .full, .rounded:
            let fullVC = FullViewController()
            self.navigationController?.pushViewController(fullVC, animated: true)
        case .upperRound:
            let upperVC = UpperRoundViewController()
            self.navigationController?.pushViewController(upperVC, animated: true)
        case .lowerRound:
            let lowerVC = LowerRoundViewController()
            self.navigationController?.pushViewController(lowerVC, animated: true)
        case .floating:
            let floatingVC = FlowtingViewController()
            self.navigationController?.pushViewController(floatingVC, animated: true)
        }
    }
}
