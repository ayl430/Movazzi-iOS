//
//  BookmarkHeaderUIView.swift
//  Movazzi
//
//  Created by yeri on 2022/03/21.
//

import UIKit

class BookmarkHeaderUIView: UIView {

    // MARK: - Properties
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "HCR Dotum", size: 18.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerLabel.frame = CGRect(x: 30, y: 0, width: self.frame.width - 60, height: self.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
