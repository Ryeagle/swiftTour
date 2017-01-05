//
//  ViewController.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/3.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    //MARK: Properties
    var tours = [Tour]()
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadSamples()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDelegate & UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tours.count
    }
    
    override  func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = tours[indexPath.row].tourName
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let cellText = cell?.textLabel?.text
        
        if cellText == "ProgressAnimation" {
            let vc = ProgressViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if cellText == "GradientAnimation" {
            let vc = GradientViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    //MARK: Private

    private func setupTableView() {
        tableView.rowHeight = 80
    }

    private func loadSamples() {
        tours += [
            Tour(tourName: "ProgressAnimation"),
            Tour(tourName: "GradientAnimation")
        ]
    }
}

