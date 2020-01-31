//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by Islas on 1/24/20.
//  Copyright © 2020 Catskillet. All rights reserved.
//

import Foundation

struct ArticleViewModel{
    private let article: Article
}

extension ArticleViewModel{
    init(_ article: Article){
        self.article = article
    }
}

extension ArticleViewModel{
    var title: String{
        return article.title ?? ""
    }
    
    var description: String{
        return article.description ?? ""
    }
}
