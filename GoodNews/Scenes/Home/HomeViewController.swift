//
//  HomeViewController
//  GoodNews
//
//  Created by Islas on 1/23/20.
//  Copyright © 2020 Catskillet. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UITableViewController {

    var homeViewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Good News - Home"
        tableView.tableFooterView = UIView()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        // TODO: Put this on viewModel
        WebService().getArticles(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=9eaedc9c57a04707b5cf1a9e4e87010f")!) { [weak self] (articles) in
            self?.homeViewModel = HomeViewModel(articles)
            DispatchQueue.main.async{ [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel?.numberOfSections ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as? ArticleCell else{return UITableViewCell()}
        cell.fillCell(articleVM: (homeViewModel?.articleAtIndex(indexPath.row))!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


