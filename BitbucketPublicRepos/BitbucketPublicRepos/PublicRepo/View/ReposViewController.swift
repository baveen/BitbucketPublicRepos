//
//  ReposViewController.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import UIKit
let cellIdentifier: String = "CellIdentifier"
let reloadCellIdentifier: String = "ReloadCellIdentifier"

class ReposViewController: UIViewController, PresenterToViewProtocol {
    
    var presenter: ViewToPresenterProtocol?

    var reposCollection = [PublicRepo]()
    var isNextBatchAvailable: Bool = false

    lazy var tableView: UITableView = {
        let tblView = UITableView()
        tblView.separatorStyle = .singleLine
        return tblView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PublicRepoTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(ReloadTableViewCell.self, forCellReuseIdentifier: reloadCellIdentifier)
        presenter?.loadRepos()

    }

    func configureViews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    
    func showFetchFailedMessage(message: String) {
        
    }
    
    func showFetchedRepos(repos: [PublicRepo]) {
        reposCollection += repos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateDataAvailablity(_ available: Bool) {
        isNextBatchAvailable = available
    }
    
}

extension ReposViewController: UITableViewDelegate, UITableViewDataSource, ReloadCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isNextBatchAvailable ? reposCollection.count + 1 : reposCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == reposCollection.count, isNextBatchAvailable {
            let cell = tableView.dequeueReusableCell(withIdentifier: reloadCellIdentifier, for: indexPath) as! ReloadTableViewCell
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PublicRepoTableViewCell
        
        let rep = reposCollection[indexPath.row]
        cell.update(repo: rep, at: cell)
        cell.updateImage(owner: rep.owner)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func fetchNextAvailbaleData() {
        presenter?.loadRepos()
    }
    
    func cellForUserId(_ userId: String) -> PublicRepoTableViewCell? {
        var cell: PublicRepoTableViewCell?
        if let index = reposCollection.firstIndex(where: { $0.owner?.accountId == userId }) {
            let indexPath = IndexPath(row: index, section: 0)
            DispatchQueue.main.async {
                cell = self.tableView.cellForRow(at: indexPath) as? PublicRepoTableViewCell
            }
        }
        return cell
    }
}
