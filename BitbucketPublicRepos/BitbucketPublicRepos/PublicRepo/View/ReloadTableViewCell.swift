//
//  ReloadTableViewCell.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import UIKit

protocol ReloadCellDelegate: AnyObject {
    func fetchNextAvailbaleData()
}

class ReloadTableViewCell: UITableViewCell {
    
    weak var delegate: ReloadCellDelegate?
    
    lazy var reloadButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("NEXT", for: .normal)
        btn.setTitleColor(.brown, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }

    func configureCell() {
        contentView.addSubview(reloadButton)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        reloadButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        reloadButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        reloadButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        reloadButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        reloadButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    @objc func nextButtonClicked() {
        delegate?.fetchNextAvailbaleData()
    }

}
