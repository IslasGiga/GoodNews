//
//  HomeViewController
//  GoodNews
//
//  Created by Islas on 1/23/20.
//  Copyright © 2020 Catskillet. All rights reserved.
//

import UIKit
import SnapKit


class ArticleTableViewCell: UITableViewCell{
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = .darkGray
        return label
    }()
    
    var articleVM: ArticleViewModel?{
        didSet{
            self.titleLabel.text = articleVM?.title
            self.descriptionLabel.text = articleVM?.description
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().inset(16)
        })
        
        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        })
    }
    
    func fillCell(articleVM: ArticleViewModel){
        self.articleVM = articleVM
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeViewController: UITableViewController {

    var articleListVM: ArticleListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Good News - Home"
        tableView.tableFooterView = UIView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        WebService().getArticles(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=9eaedc9c57a04707b5cf1a9e4e87010f")!) { [weak self] (articles) in
            self?.articleListVM = ArticleListViewModel(articles)
            DispatchQueue.main.async{ [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articleListVM?.numberOfSections ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as? ArticleTableViewCell else{return UITableViewCell()}
        cell.fillCell(articleVM: (articleListVM?.articleAtIndex(indexPath.row))!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


