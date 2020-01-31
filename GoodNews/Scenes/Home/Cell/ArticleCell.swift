//
//  ArticleCell.swift
//  GoodNews
//
//  Created by Islas on 1/31/20.
//  Copyright © 2020 Catskillet. All rights reserved.
//
import UIKit
import Foundation

class ArticleCell: UITableViewCell{
    
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
