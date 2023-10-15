//
//  PictureCell.swift
//  project10-12-milestone
//
//  Created by Dwiki Dwiki on 15/10/23.
//

import UIKit

class PictureCell: UITableViewCell {
    static let identifier = "CustomCell"
    
    private let myImageView:UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .label
        return iv
    }()
    
    private var caption: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.text = "Error"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with image:String, and label: String) {
        print(image,"ss")
        self.myImageView.image = UIImage(contentsOfFile: image)
        self.caption.text = label
    }
    
    private func setupUI() {
        self.contentView.addSubview(myImageView)
        self.contentView.addSubview(caption)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        caption.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            myImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
            myImageView.heightAnchor.constraint(equalToConstant: 90),
            myImageView.widthAnchor.constraint(equalToConstant: 90),
            
            caption.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 12),
            caption.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            caption.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            caption.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
