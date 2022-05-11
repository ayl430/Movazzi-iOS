//
//  DiaryTableHeaderUIView.swift
//  Movazzi
//
//  Created by yeri on 2022/04/13.
//

import UIKit

class DiaryTableHeaderUIView: UIView {
    
    // MARK: - Properties
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HCR Dotum", size: 18.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let headerButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체보기", for: .normal)
        button.setTitleColor(UIColor.tintColorBrown, for: .normal)
        button.titleLabel?.font = UIFont(name: "HCR Dotum", size: 16.0)
        return button
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(headerLabel)
        addSubview(headerButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()

        headerLabel.frame = CGRect(x: 20, y: 0, width: self.frame.width - 120, height: self.frame.height)
        headerButton.frame = CGRect(x: headerLabel.frame.width + 30, y: 10, width: 70 , height: self.frame.height - 20)
    }

    
}
