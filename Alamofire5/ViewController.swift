//
//  ViewController.swift
//  Alamofire5
//
//  Created by Chi Xuan on 09/11/2021.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var articles: [ArticlesModel] = []
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        title = "Alamofire Demo"
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        AF.request("http://api.allfootballapp.com/app/tabs/iphone/1.json?countryCode=VN&platform=iphone&version=337&uuid_id=0").responseJSON { (response) in
            if let value = response.value as? [String: Any] {
                if let articles = value["articles"] as? [[String: Any]] {
                    self.articles = articles.map({ ArticlesModel(json: $0) })
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


}

