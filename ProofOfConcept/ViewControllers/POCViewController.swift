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
    let ESTIMATED_TABLE_ROW_HEIGHT: CGFloat = 400.0
    var arrayOfContent : [ContentViewModel] = []
    var refreshControl: UIRefreshControl!
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
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
            POCAPIManager.shareInstance.getAllContentData { (success, rowsData, navTitle) in
                self.arrayOfContent = rowsData?.map({ return ContentViewModel(content: $0) }) ?? []
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
        //Network checking
        if NetworkState.isConnected() {
            POCAPIManager.shareInstance.getAllContentData { (success, rowsData, navTitle) in
                self.arrayOfContent = rowsData?.map({ return ContentViewModel(content: $0) }) ?? []
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
        tableView.register(POCTableViewCell.self, forCellReuseIdentifier: Constants.imageCellIdentifier)
        
        // set constraints
        tableView.pin(to: tableView)
        
        // set row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ESTIMATED_TABLE_ROW_HEIGHT
    }
}

//MARK:UITableViewDataSource methods
extension POCViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.imageCellIdentifier) as! POCTableViewCell
        
        let contentViewModelObject = arrayOfContent[indexPath.row]
        if contentViewModelObject.imageHref != nil
        {
            cell.rowImageView.sd_setImage(with: URL(string: contentViewModelObject.imageHref!), placeholderImage: UIImage(named: Constants.placeholder),options: SDWebImageOptions([]), completed: { image, error, cacheType, imageURL in
                if (error != nil) {
                    cell.rowImageView.isHidden = true
                    print("Error while downloading image: \(error.debugDescription)")
                } else {
                    cell.rowImageView.isHidden = false
                }
            })
        } else {
            cell.rowImageView.isHidden = true
        }
        cell.rowTitleLabel.text = contentViewModelObject.title
        cell.rowDescriptionLabel.text = contentViewModelObject.descriptions
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
