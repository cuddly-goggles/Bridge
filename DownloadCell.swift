//
//  DownloadCell.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/21/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import MZDownloadManager
import SnapKit
import KYCircularProgress
class DownloadCell: UITableViewCell {

    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var remainSize: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var progressbar: KYCircularProgress!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backview.backgroundColor = UIColor.white
        backview.layer.cornerRadius = 5
        backview.layer.masksToBounds = true
        backgroundColor = .none
        contentView.backgroundColor = .none
        progressbar.backgroundColor = .none
        progressbar.colors = [.black]
        progressbar.showGuide = true
        
        stackview.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(15)
            maker.left.equalToSuperview().offset(90)
            maker.right.equalToSuperview().offset(-15)
            maker.bottom.equalToSuperview().offset(-15)
        }
        progressbar.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(15)
            maker.left.equalToSuperview().offset(15)
            maker.right.equalTo(stackview)
            maker.bottom.equalToSuperview().offset(-5)
        }
        backview.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(5)
            maker.left.equalToSuperview().offset(5)
            maker.right.equalToSuperview().offset(-5)
            maker.bottom.equalToSuperview().offset(-5)
        }

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellForRowAtIndexPath(_ indexPath : IndexPath, downloadModel: MZDownloadModel) {
        fileName.text = downloadModel.fileName
        remainSize.text = "\(downloadModel.downloadedFile?.size ?? 0) \(downloadModel.downloadedFile?.unit ?? "KB") of \(downloadModel.file?.size ?? 0) \(downloadModel.file?.unit ?? "KB")"
        speed.text = "\(downloadModel.speed?.speed ?? 0) \(downloadModel.speed?.unit ?? "KB")\\s"
        progressbar.progress = Double(downloadModel.progress)
    }

}
