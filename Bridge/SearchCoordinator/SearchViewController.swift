//
//  SearchViewController.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 3/7/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

import UIKit
import MZDownloadManager
import NVActivityIndicatorView
import SnapKit
import UIView_Shake
import Alamofire
import RMessage

class SearchViewController: UIViewController {
    var downloadManager: MZDownloadManager? = nil
    lazy var searchbtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Search", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.gray, for: .highlighted)
        btn.addTarget(self, action: #selector(search), for: .touchUpInside)
        return btn
    }()
    lazy var linkfield: UITextField = {
        let field = UITextField()
        field.placeholder = ""
        field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing
        field.placeholder = "e.g https://www.youtube.com/watch?v=7X9kpHB7Aow"
        return field
    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "The Intuitive Interface Lets You Extract Videos From Any Websites Effortlessly"
        label.textAlignment = .center
        label.font = label.font.withSize(17)
        return label
    }()
    
    @objc func search() {
        if let url = linkfield.text {
            if url != "" {
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(type: .ballRotateChase))
                API.shared.extract(url, completion: { (entries) in
                    self.entriesActions(entries)
                    DispatchQueue.main.async {
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
                })
            }else {
                linkfield.shake()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.waitforServer()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        view.addSubview(titlelabel)
        view.addSubview(searchbtn)
        view.addSubview(linkfield)
        view.backgroundColor = .white
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        linkfield.snp.remakeConstraints { (make) in
            make.height.equalTo(40)
            make.leftMargin.equalToSuperview().offset(10)
            make.rightMargin.equalToSuperview().offset(-10)
            //make.centerX.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview().offset(-30)
        }
        searchbtn.snp.remakeConstraints { (make) in
            make.topMargin.equalTo(linkfield.snp.bottomMargin).offset(30)
            make.leftMargin.rightMargin.equalToSuperview()
        }
        
        titlelabel.snp.remakeConstraints { (maker) in
            maker.bottom.equalTo(linkfield.snp.top).offset(-50)
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
        }
    }
    
    func entriesActions(_ ‌entries: Entires) {
        let allertController = UIAlertController(title: nil, message: "Select Video", preferredStyle: .actionSheet)
        for entry in ‌entries.entries {
            let action = UIAlertAction(title: entry.title, style: .default, handler: { (action) in
                self.formatsAction(entry)
            })
            allertController.addAction(action)
        }
        allertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        presentAlertview(allertController)
    }
    
    func formatsAction(_ entry: Entity){
        let allertController = UIAlertController(title: nil, message: entry.title, preferredStyle: .actionSheet)
        for fm in entry.formats {
            let action = UIAlertAction(title: "\(fm.ext) - \(fm.format)", style: .default, handler: { (action) in
                
                self.downloadManager?.addDownloadTask("\(entry.title) - \(fm.format).\(fm.ext)", fileURL: fm.url)
                
                RMessage.showNotification(withTitle: "Download Started.", type: .success, customTypeName: nil, callback: nil)
                
            })
            allertController.addAction(action)
        }
        allertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        presentAlertview(allertController)
    }
    
    
    func presentAlertview(_ alertController: UIAlertController) {
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true, completion: nil)
        
    }
    
    
}

