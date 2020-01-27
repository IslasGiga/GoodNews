//
//  WebService.swift
//  GoodNews
//
//  Created by Islas on 1/23/20.
//  Copyright © 2020 Catskillet. All rights reserved.
//

import Foundation

class WebService{
    func getArticles(url: URL, completion: @escaping ([Article]) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                completion([])
            }else if let data = data, let responseModel = try? JSONDecoder().decode(ArticlesResult.self, from: data){
                completion(responseModel.articles ?? [])
            }else{
                completion([])
            }
        }.resume()
    }
}
