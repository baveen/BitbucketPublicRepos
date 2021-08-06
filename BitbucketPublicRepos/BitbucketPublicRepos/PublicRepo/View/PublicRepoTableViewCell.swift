//
//  PublicRepoTableViewCell.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import UIKit

class PublicRepoTableViewCell: UITableViewCell {

    lazy var avatarImageView: UIImageView = {
        let imv = UIImageView()
        imv.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    lazy var repositoryNameLabel: UILabel = {
        let repoName = UILabel()
        return repoName
    }()
    
    lazy var typeNameLabel: UILabel = {
        let type = UILabel()
        return type
    }()
    
    lazy var createdDateLabel: UILabel = {
        let date = UILabel()
        return date
    }()
    
    private var labelHolderStackView: UIStackView = {
        let labelHolder = UIStackView()
        labelHolder.axis = .vertical
        labelHolder.distribution = .fillEqually
        return labelHolder
    }()
    
    private var holderStackView: UIStackView = {
        let holder = UIStackView()
        holder.axis = .horizontal
        holder.spacing = 16
        return holder
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        configureCell()
    }
    
    
    func configureCell(){
        customize(label: repositoryNameLabel)
        customize(label: typeNameLabel)
        customize(label: createdDateLabel)
        
        contentView.addSubview(holderStackView)
        holderStackView.addArrangedSubview(avatarImageView)
        holderStackView.addArrangedSubview(labelHolderStackView)
        labelHolderStackView.addArrangedSubview(repositoryNameLabel)
        labelHolderStackView.addArrangedSubview(typeNameLabel)
        labelHolderStackView.addArrangedSubview(createdDateLabel)

        holderStackView.translatesAutoresizingMaskIntoConstraints = false
        holderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        holderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        holderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        holderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        labelHolderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        repositoryNameLabel.text = nil
        typeNameLabel.text = nil
        createdDateLabel.text = nil
    }

    func update(repo: PublicRepo, at cell: PublicRepoTableViewCell) {
        DispatchQueue.main.async {
            cell.repositoryNameLabel.text = "Repo Name: \(repo.fullName ?? "")".capitalized
            cell.typeNameLabel.text = "Type: \(repo.type ?? "")".capitalized
            cell.createdDateLabel.text = "Created On: \(repo.createdOn ?? "")".capitalized
        }
    }
    
    
    
    func customize(label: UILabel) {
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
    }
}

extension UIImageView {
    var imageCache: NSCache<NSString, UIImage> {
        return NSCache<NSString, UIImage>()
    }

    func updateImage(owner: RepoOwner?) {
        guard  let userId = owner?.accountId as NSString? else {
            return
        }
        if let img = imageCache.object(forKey: userId) {
            DispatchQueue.main.async {
                self.image = img
                return
            }
        }
        DispatchQueue(label: "download.images", qos: .background, attributes: []).async {
            if let urlStr = owner?.links?.avatarLink?.href, let url = URL(string: urlStr), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: userId)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

