//
//  NewsViewController.swift
//  Alamofire5
//
//  Created by daona on 10/11/2021.
//

import UIKit
import Alamofire
import Kingfisher

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var headlineData: HeadlineModel = HeadlineModel()
    var articlesData: [ArticlesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        tableView.delegate = self
        tableView.dataSource = self
        AF.request(CommonStrings.urlAPI).response { (response) in
            guard let data = response.data else { return }
            do {
                self.headlineData = try JSONDecoder().decode(HeadlineModel.self, from: data)
                self.articlesData = self.headlineData.articles
            } catch let error {
                print("Parse error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.titleLabel.text = articlesData[indexPath.row].title
        let url = URL(string: articlesData[indexPath.row].thumb)
        cell.thumbImageView.kf.setImage(with: url)
        if indexPath.row == articlesData.count - 1 {
            self.loadMoreData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "WebViewViewController") as! WebViewViewController
        controller.url = articlesData[indexPath.row].url
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func loadMoreData() {
        AF.request(headlineData.next).response { (response) in
            guard let data = response.data else { return }
            do {
                self.headlineData = try JSONDecoder().decode(HeadlineModel.self, from: data)
                self.articlesData = self.articlesData + self.headlineData.articles
            } catch let error {
                print("Parse error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}


