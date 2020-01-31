//
//  ArticleListViewModel.swift
//  GoodNews
//
//  Created by Islas on 1/24/20.
//  Copyright © 2020 Catskillet. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol{
    
    var numberOfSections: Int {get}
    func numberOfRowsInSection(_ index: Int) -> Int
    func articleAtIndex(_ index: Int) -> ArticleViewModel
    func getArticles(completion: @escaping () -> Void)
    
    // TODO: Create binding
}

class HomeViewModel{
    private var articles: [Article] = []
    private let service: WebService
    
    init(service: WebService){
        self.service = service
    }
}

extension HomeViewModel{
    
}

extension HomeViewModel: HomeViewModelProtocol{
    // TODO: Try to make this function a Pure function or an High Order Function
    func getArticles(completion: @escaping () -> Void){
        service.getArticles(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=9eaedc9c57a04707b5cf1a9e4e87010f")!) { [weak self] (articles) in
            self?.articles = articles
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 3000)) {
                completion()
            }
        }
    }
    
    var numberOfSections: Int{
        return 1
    }
    
    func numberOfRowsInSection(_ index: Int) -> Int{
        return articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel{
        return ArticleViewModel(articles[index])
    }
}
