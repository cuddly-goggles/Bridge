//
//  ExtractLink.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/21/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import UIView_Shake
import RMessage
import AlertOnboarding

class ExtractLinkViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var linktext: UITextField!
    @IBOutlet weak var downloadBtn: UIButton!
    
    @IBAction func help(_ sender: Any) {
        let arrayOfImage = ["socialmedia", "port", "software"]
        let arrayOfTitle = ["Bridge", " Port of youtube-dl library", "Beta Version"]
        let arrayOfDescription = ["The easiest way to download videos from Youtube, Tumblr, Dailymotion, Vine, Facebook, Instagram, Vimeo, Adobe.tv, Soundcloud and few more sites.",
                                  "An experimental port of the youtube-dl project to IOS.",
                                  "It’s important to stress that this is a beta version, so there is almost guaranteed to be something that has slipped through the cracks."]
        let alertView = AlertOnboarding(arrayOfImage: arrayOfImage, arrayOfTitle: arrayOfTitle, arrayOfDescription: arrayOfDescription)
        alertView.show()
    }
    @IBAction func download(_ sender: Any) {
        
        if let url = linktext.text {
            if url != "" {
                startAnimating()
                API.shared.info(url, completion: { (entries, sucess) in
                    switch sucess {
                    case true:
                        guard let entries = entries else {
                            return
                        }
                        switch entries.errorOccured {
                        case true:
                            DispatchQueue.main.async {
                                self.stopAnimating()
                            }
                            RMessage.showNotification(withTitle: "Error", subtitle: entries.errmsg, type: .error, customTypeName: nil, callback: nil)
                            
                        case false:
                            DispatchQueue.main.async {
                                self.stopAnimating()
                                debugPrint(entries.videos.count)
                                self.playlistActionArray(entries: entries)
                            }
                        }
                    case false:
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                    }
                })
            } else {
                linktext.shake()
            }
        }
        
        
    }
    
    var downloadingViewObj: DownloadManagerViewController?
    //var swiftYD = SwiftyDL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waitforServer()
        constraints()
        setUpDownloadingViewController()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    
    func constraints() {
        
        linktext.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().inset(20)
            maker.right.equalToSuperview().inset(20)
            maker.centerY.equalToSuperview().inset(-40)
            maker.centerX.equalToSuperview()
        }
        
        downloadBtn.snp.makeConstraints { (maker) in
            //maker.left.equalToSuperview().inset(100)
            //maker.right.equalToSuperview().inset(-100)
            maker.centerY.equalToSuperview().inset(40)
            maker.centerX.equalToSuperview()
        }
    }
    
    
    func playlistActionArray(entries: Entries) {
        if entries.videos.count == 1 {
            self.actionArray(video: entries.videos[0])
        } else {
           let alertController = UIAlertController(title: nil, message: "\(entries.title ?? "")", preferredStyle: .actionSheet)
            for video in entries.videos {
                let action = UIAlertAction(title: "\(video.title ?? "")", style: .default, handler: { (action) in
                    self.actionArray(video: video)
                })
                alertController.addAction(action)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            presentAlertview(alertController)
        }
    }
    
    
    func actionArray(video: Video) {
        let alertController = UIAlertController(title: nil, message: "\(video.title ?? "")", preferredStyle: .actionSheet)
        for exts in video.formats {
            let action = UIAlertAction(title: "\(exts.ext ?? "") - \(exts.format ?? "")", style: .default, handler: { (action) in
                self.copyORdownload(exts, name: video.title ?? "no title")
            })
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        presentAlertview(alertController)
    }
    
    func copyORdownload(_ exts: Format, name: String) {
        let alertController = UIAlertController(title: nil, message: "\(name)", preferredStyle: .actionSheet)
        let downloadAction = UIAlertAction(title: "Download", style: .default, handler: { (action) in
            self.addDownloadTask(exts, name: name)
        })
        alertController.addAction(downloadAction)
        let copyAction = UIAlertAction(title: "Copy to Clipboard", style: .default, handler: { (action) in
            self.copyToClipboard(exts, name: name)
        })
        alertController.addAction(copyAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        presentAlertview(alertController)
    }
    
    func copyToClipboard(_ format: Format, name: String) {
        guard let url = format.url else {
            return
        }
        UIPasteboard.general.string = url
        RMessage.showNotification(withTitle: "Success", subtitle: "URL Copied.", type: .success, customTypeName: nil, callback: nil)
    }
    
    func addDownloadTask(_ format: Format, name: String) {
        guard let url = format.url else {
            return
        }
        
        downloadingViewObj?.downloadManager.addDownloadTask("\(name).\(format.ext ?? "mp4")", fileURL: url)
        RMessage.showNotification(withTitle: "Success", subtitle: "Download Started.", type: .success, customTypeName: nil, callback: nil)
    }
    
    func presentAlertview(_ alertController: UIAlertController) {
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true, completion: nil)

    }
    
    func setUpDownloadingViewController() {
        let tabBarTabs : NSArray? = self.tabBarController?.viewControllers as NSArray?
        let mzDownloadingNav : UINavigationController = tabBarTabs?.object(at: 1) as! UINavigationController
        
        downloadingViewObj = mzDownloadingNav.viewControllers[0] as? DownloadManagerViewController
    }
    
    
    func waitforServer() {
        let myqueue = DispatchQueue(label: "waitforsercer")
        startAnimating(nil, message: nil, messageFont: nil, type: .ballScaleMultiple, color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
        myqueue.async {
            while true {
                let task = URLSession.shared.synchronousDataTask(with: URL(string: "http://127.0.0.1:9191/api/version")!)
                if task.1 != nil {
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        RMessage.showNotification(withTitle: "Server Initialized", subtitle: "Server is now running.", type: .success, customTypeName: nil, callback: nil)
                    }
                    break
                }
                sleep(2)
            }
        }
        
        
    }

}
