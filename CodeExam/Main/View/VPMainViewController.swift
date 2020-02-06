//
//  ViewController.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import UIKit

class VPMainViewController: UIViewController {

    var tableView: UITableView?
    var presenter: VPMainPresenterProtocol?
    var vpMainViewDataSource: VPMainViewDataSource?
    var refreshControl = UIRefreshControl()

    let serviceCall = ServiceCallApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Explore Sections"
        view.backgroundColor = .white
        createTableView()
        fetchSections()
    }

    func fetchSections() {
        presenter?.fetchSections { [weak self] sections in
                self?.vpMainViewDataSource?.setSections(sections: sections)
                self?.tableView?.dataSource = self?.vpMainViewDataSource
                self?.tableView?.delegate = self?.vpMainViewDataSource
                self?.tableView?.reloadData()
                self?.refreshControl.endRefreshing()
        }
    }
}

extension VPMainViewController {
    func createTableView() {
        vpMainViewDataSource = VPMainViewDataSource(presenter: presenter)
        tableView = UITableView(frame: view.frame)
        tableView?.tableFooterView = UIView()
        let noDataLabel = UILabel()
        noDataLabel.text = "There is no data"
        noDataLabel.textAlignment = .center
        tableView?.backgroundView = noDataLabel
        if let tableView = tableView {
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView?.addSubview(refreshControl)
    }

    @objc
    func refresh() {
        presenter?.invalidateCache()
        fetchSections()
    }
}

class VPMainViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    var sections: [ViaplaySection]?
    var presenter: VPMainPresenterProtocol?

    init(presenter: VPMainPresenterProtocol?) {
        self.presenter = presenter
    }

    func setSections(sections: [ViaplaySection]) {
        self.sections = sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = sections?[indexPath.row].title 
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let href = sections?[indexPath.row].href {
            presenter?.showDetail(href: href)
        }
    }
    
}
