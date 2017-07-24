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
                API.shared.info(url, completion: { (video) in
                    switch video.errorOccured {
                    case true:
                        break
                    case false:
                        break
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
        
        //setUpDownloadingViewController()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        linktext.snp.makeConstraints { (maker) in
            maker.left.equalTo(view).offset(20)
            maker.right.equalTo(view).offset(-20)
            maker.center.equalToSuperview().offset(-40)
        }
        
        downloadBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(view).offset(100)
            maker.right.equalTo(view).offset(-100)
            maker.center.equalToSuperview().offset(40)
        }
    }

    
    /*func actionArray(video: Video) {
        let alertController = UIAlertController(title: nil, message: "\(video.title ?? "")", preferredStyle: .actionSheet)
        for exts in video.formats {
            let action = UIAlertAction(title: "\(exts.ext ?? "") - \(exts.format ?? "")", style: .default, handler: { (action) in
                self.addDownloadTask(exts, name: video.title ?? "no title")
            })
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func addDownloadTask(_ format: Format, name: String) {
        guard let url = format.url else {
            return
        }
        
        downloadingViewObj?.downloadManager.addDownloadTask("\(name).\(format.ext ?? "mp4")", fileURL: url)
        RMessage.showNotification(withTitle: "Success", subtitle: "Download Started.", type: .success, customTypeName: nil, callback: nil)
    }
    
    func setUpDownloadingViewController() {
        let tabBarTabs : NSArray? = self.tabBarController?.viewControllers as NSArray?
        let mzDownloadingNav : UINavigationController = tabBarTabs?.object(at: 1) as! UINavigationController
        
        downloadingViewObj = mzDownloadingNav.viewControllers[0] as? DownloadManagerViewController
    }
    */

}



