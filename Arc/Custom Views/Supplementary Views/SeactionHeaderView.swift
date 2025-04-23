//
//  PopulerHeaderView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class SeactionHeaderView: UICollectionReusableView {
    static let cellIdentifier = "PopulerHeaderView"
    
    var title : String? {
        didSet {
            headerTitle.text = title
        }
    }
    
    let headerTitle : UILabel = {
       var title = UILabel()
        title .text = "Populer"
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        confgure()
    }
    
    
    private func confgure(){        
        addSubview(headerTitle)
        headerTitle.pinToEages(to: self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
