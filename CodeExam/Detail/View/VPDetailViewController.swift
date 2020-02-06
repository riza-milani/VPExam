//
//  VPDetailViewController.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import UIKit

class VPDetailViewController: UIViewController {

    var presenter: VPDetailPresenter?
    var sectionTitleLabel: UILabel?
    var sectionDescriptionLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSectionTitleLabel()
        createSectionDescriptionLabel()
        presenter?.fetchDetail{ [weak self] vpModel in
            guard let vpModel = vpModel else {
                self?.sectionTitleLabel?.text = "Please try agian later"
                self?.sectionDescriptionLabel?.text = "Something happened wrong."
                return
            }
            self?.sectionTitleLabel?.text = vpModel.title
            self?.sectionDescriptionLabel?.text = vpModel.vpModelDescription
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        presenter?.free()
        presenter = nil
    }
}

extension VPDetailViewController {
    func createSectionTitleLabel() {
        sectionTitleLabel = UILabel()
        sectionTitleLabel?.text = "Title"
        sectionTitleLabel?.textAlignment = .center
        sectionTitleLabel?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        sectionTitleLabel?.layer.cornerRadius = 5
        sectionTitleLabel?.clipsToBounds = true
        sectionTitleLabel?.numberOfLines = 0
        sectionTitleLabel?.font = sectionTitleLabel?.font.withSize(20)
        if let sectionTitleLabel = sectionTitleLabel {
            view.addSubview(sectionTitleLabel)
            sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            sectionTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
            sectionTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
            sectionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            sectionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }

    func createSectionDescriptionLabel() {
        sectionDescriptionLabel = UILabel()
        sectionDescriptionLabel?.text = "Description"
        sectionDescriptionLabel?.textAlignment = .left
        sectionDescriptionLabel?.textColor = .gray
        sectionDescriptionLabel?.numberOfLines = 0
        sectionDescriptionLabel?.font = sectionTitleLabel?.font.withSize(14)
        if let sectionDescriptionLabel = sectionDescriptionLabel, let sectionTitleLabel = sectionTitleLabel {
            view.addSubview(sectionDescriptionLabel)
            sectionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            sectionDescriptionLabel.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 10).isActive = true
            sectionDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            sectionDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }
}
