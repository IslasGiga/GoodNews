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

    var loadingView: UIView = {
        let view = UIView(frame: .zero)
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
        }
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 300, height: 300))
        })

        return view
    }()
    
    var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Good News - Home"
        tableView.tableFooterView = UIView()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        loadingView.frame = self.view.bounds
        view.insertSubview(loadingView, aboveSubview: tableView)
        
        viewModel.getArticles(){
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.loadingView.removeFromSuperview()
            }
        }
    }
}

extension HomeViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as? ArticleCell else{return UITableViewCell()}
        cell.fillCell(articleVM: (viewModel.articleAtIndex(indexPath.row)))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


