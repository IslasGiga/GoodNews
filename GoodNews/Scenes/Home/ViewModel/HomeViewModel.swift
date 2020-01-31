//
//  ArticleListViewModel.swift
//  GoodNews
//
//  Created by Islas on 1/24/20.
//  Copyright © 2020 Catskillet. All rights reserved.
//

import Foundation

struct HomeViewModel{
    private let articles: [Article]
}

extension HomeViewModel{
    init(_ articles: [Article]){
        self.articles = articles
    }
}

extension HomeViewModel{
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