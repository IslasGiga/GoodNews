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
    func getArticles(url: URL)
    
    // TODO: Create binding
}

struct HomeViewModel{
    private var articles: [Article]
}

extension HomeViewModel{
    init(_ articles: [Article]){
        self.articles = articles
    }
    
    // Implementar injeção de dependencia, passando o service aqui
//    init(){
//
//    }
}

extension HomeViewModel: HomeViewModelProtocol{
    func getArticles(url: URL) {
        // TODO: Fetch data from WebService
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
