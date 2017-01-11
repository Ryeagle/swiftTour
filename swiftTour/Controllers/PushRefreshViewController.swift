//
//  PushRefreshViewController.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/6.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit

class PushRefreshViewController: UITableViewController, PullRefreshViewDelegate{

    //MARK: Types
    
    struct Constants {
        struct ColorPalette {
            static let purple = UIColor(red:0.31, green:0.20, blue:0.49, alpha:1.0)
            static let backgroundColor = UIColor(red: 43/255, green: 35/255, blue: 77/255, alpha: 1)
        }
    }

    //MARK: Properties
    
    let kPullRefreshViewHeight: CGFloat = UIScreen.main.bounds.size.height * 0.22
    var pullRefreshView: PullRefeshView!
    let items = ["Avatar", "Star Wars", "Interstellar", "Predator", "The Martian", "They Live", "Contact", "Alien", "Independence Day", "Signs", "District 9", "Superman Returns"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavBar()
        configTablView()
        configRefreshRect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "pullRefreshCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "pullRefreshCell")
        }
        cell?.textLabel!.text = items[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pullRefreshView.scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pullRefreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    //MARK: PullRefreshViewDelegate

    func PullRefreshViewDidRefresh(_ PullRefreshView: PullRefeshView) {
        //Method delay as loading data.
        delay(seconds: 5) {
            //Loading data over
            PullRefreshView.endRefreshing()
        }
    }
    
    //MARK: Private Method
    
    private func configNavBar() {
        self.navigationController?.navigationBar.barTintColor = Constants.ColorPalette.purple
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    private func configTablView() {
        self.view.backgroundColor = Constants.ColorPalette.backgroundColor
    }
    
    private func configRefreshRect() {
        let refreshRect = CGRect(x: 0.0, y: -kPullRefreshViewHeight, width: view.frame.size.width, height: kPullRefreshViewHeight)
        pullRefreshView = PullRefeshView(frame: refreshRect, scrollView: self.tableView)
        pullRefreshView.delegate = self
        view.addSubview(pullRefreshView)
    }
}
