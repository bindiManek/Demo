//
//  ViewController.swift
//  Demo
//
//  Created by Manek Bindi on 03/09/19.
//  Copyright © 2019 Bindi Manek. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var tblList: UITableView!
    var titleData = [TitleData]()
    var selectedTitleData = [TitleData]()
//    var refreshControl = UIRefreshControl()
    var strPage:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
//        self.tblList.addSubview(refreshControl) // not required when using UITableViewController
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DataService.dataService.getData(page: "1") { (dataList) in
            self.titleData = dataList
            self.navigationItem.title = "Total Posts \(self.titleData.count)"
            self.tblList.reloadData()
        }
    }
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        DataService.dataService.getData(page: "1") { (dataList) in
            self.titleData.removeAll()
            self.titleData = dataList
            self.tblList.reloadData()
            self.navigationItem.title = "Total Posts \(self.titleData.count)"
//            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DisplayCell
        
        // Check if the last row number is the same as the last current data element
        if indexPath.row == self.titleData.count - 1 {
            strPage += 1
            DataService.dataService.getData(page: "\(strPage)") { (dataList) in
                for i in 0 ..< dataList.count {
                    let temp = dataList[i]
                    self.titleData.append(temp)
                }
                self.navigationItem.title = "Total Posts \(self.titleData.count)"
                self.tblList.reloadData()
            }
        }
        let temp: TitleData
        temp = titleData[indexPath.row]
        cell.lblTitle.text = temp.Title
        cell.lblCreatedAt.text = temp.CreatedAt
        
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let tempOld: TitleData
//        tempOld = titleData[indexPath.row]
//
//        if !self.selectedTitleData.contains(where: {$0.Title == tempOld.Title}) {
//            self.selectedTitleData.append(tempOld)
//        } else {
//            self.selectedTitleData.removeAll{$0.Title == tempOld.Title}
//        }
//        self.tblList.reloadData()
//        self.navigationItem.title = "Total Post \(titleData.count)"
//    }
}

extension String
{   //  returns false if passed string is nil or empty
    static func isNilOrEmpty(_ string:String?) -> Bool
    {   if  string == nil                   { return true }
        return string!.isEmpty
    }
}
