//
//  POCViewController.swift
//  ProofOfConcept
//
//  Created by Pradeep Kumar Vadde (Digital) on 13/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import UIKit
import SDWebImage

class POCViewController: UIViewController {
    
    var tableView = UITableView()
    
    var arrayOfContent : [POCContentModel] = []
    
    // Image Caching
    var refreshControl: UIRefreshControl!
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    struct Cells {
        static let imageCellIdentifier = "ImageCell"
    }
    
    let sharedInstance =  POCAPIContentSingletonHelper.sharedInstance
    
    //MARK:ViewController Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(POCViewController.refreshTableView), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        self.cache = NSCache()
        
        view.backgroundColor = .white
        
        configureTableView()
        
        //MARK:MakeAPICall To GetData
        makeAPICallToGetData()
    }
    
    func makeAPICallToGetData(){
        //Network checking
        if NetworkState.isConnected() {
            POCAPIManager.getDataFrom(url: URL(string:Constants.BASE_URL)!) { (success, rowsData, navTitle) in
                self.arrayOfContent = rowsData!
                DispatchQueue.main.async {
                    self.navigationItem.title = navTitle
                    self.tableView.reloadData()
                }
            }
        } else {
            self.showOffline()
        }
    }
    // showing Popup in Offline
    private  func showOffline() -> Void {
        DispatchQueue.main.async {
            self.sharedInstance.showErrorPopupWith(title: Constants.ALERT, message: Constants.INTERNET_CONNECTION_UNAVAILABLE)
        }
    }
    
    @objc func refreshTableView(){
        //MARK:Network Checking
        if NetworkState.isConnected() {
            POCAPIManager.getDataFrom(url: URL(string: Constants.BASE_URL)!){ (success, rowsData, navTitle) in
                self.arrayOfContent = rowsData!
                // Update the UI with new response
                DispatchQueue.main.async {
                    self.navigationItem.title = navTitle
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        } else {
            self.showOffline()
        }
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        // set delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // register cells
        tableView.register(POCTableViewCell.self, forCellReuseIdentifier: Cells.imageCellIdentifier)
        
        // set constraints
        tableView.pin(to: tableView)
        
        // set row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
    }
}

//MARK:UITableViewDataSource methods
extension POCViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.imageCellIdentifier) as! POCTableViewCell
        
        let contentObject = arrayOfContent[indexPath.row]
        if contentObject.imageHref != nil
        {
            cell.rowImageView.sd_setImage(with: URL(string: contentObject.imageHref!), placeholderImage: UIImage(named: "placeholder"),options: SDWebImageOptions([]), completed: { image, error, cacheType, imageURL in
                if (error != nil) {
                    print("Error while downloading image: \(error.debugDescription)")
                }
            })
        } else {
            cell.rowImageView.image = nil
        }
        cell.rowTitleLabel.text = contentObject.title
        cell.rowDescriptionLabel.text = contentObject.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
