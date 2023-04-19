//
//  MyCustomCell.swift
//  combine-uikit-programmatic
//
//  Created by Kautilya Save on 4/18/23.
//

import Combine
import SwiftUI


class MyCustomCell: UITableViewCell {
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Press Me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // Combine Subject
    
    let action = PassthroughSubject<String, Never>()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 10, y: 3, width: contentView.frame.width - 40, height: contentView.frame.height - 4)
    }
    
    
    @objc func didTapButton() {
        action.send("Hello from another World!")
    }

    
}
