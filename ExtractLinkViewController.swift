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

class ExtractLinkViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var linktext: UITextField!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBAction func download(_ sender: Any) {
        
        
        //downloadingViewObj?.downloadManager.addDownloadTask("test.sample", fileURL: "http://cdn.p30download.com/?b=p30dl-software&f=Google.Chrome.v59.0.3071.115.x86_p30download.com.zip")
        guard let url = linktext.text else {
            return
        }
        if url != "" {
            startAnimating()
            swiftYD.extract(url: url) { (video) in
                
                DispatchQueue.main.async {
                    self.stopAnimating()
                    self.actionArray(video: video)
                }
            }
        } else {
            linktext.shake()
        }
        
    }
    var downloadingViewObj: DownloadManagerViewController?
    var swiftYD = SwiftyDL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDownloadingViewController()
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
    
    func actionArray(video: Video) {
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
    

    
}
