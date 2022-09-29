//
//  DownloadTableViewCell.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 5/11/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

import UIKit
import MZDownloadManager
import SnapKit
import MBCircularProgressBar


class DownloadTableViewCell: UITableViewCell {
    
    
    lazy var progressview: MBCircularProgressBarView = {
        let pv = MBCircularProgressBarView()
        pv.maxValue = 100
        pv.progressAngle = 90
        pv.progressLineWidth = 1
        pv.progressColor = .blue
        pv.progressStrokeColor = .purple
        pv.backgroundColor = .white
        return pv
    }()
    lazy var titlelabel: UILabel = {
        let lb = UILabel()
        lb.font = lb.font.withSize(16)
        lb.numberOfLines = 2
        return lb
    }()
    lazy var remainingLabel: UILabel = {
        let lb = UILabel()
        lb.font = lb.font.withSize(15)
        lb.textColor = .gray
        return lb
    }()
    lazy var speedLabel: UILabel = {
        let lb = UILabel()
        lb.font = lb.font.withSize(14)
        lb.numberOfLines = 0
        lb.textColor = .lightGray
        return lb
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(progressview)
        addSubview(titlelabel)
        addSubview(remainingLabel)
        addSubview(speedLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressview.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview().offset(5)
            maker.height.equalTo(70)
            maker.width.equalTo(progressview.snp.height)
            maker.bottom.equalToSuperview().offset(-5)
            
        }
        titlelabel.snp.remakeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.left.equalTo(progressview.snp.right).offset(5)
            maker.right.equalToSuperview()
        }
        remainingLabel.snp.remakeConstraints { (maker) in
            maker.top.equalTo(titlelabel.snp.bottom)
            maker.left.equalTo(progressview.snp.right).offset(5)
        }
        speedLabel.snp.remakeConstraints { (maker) in
            maker.top.equalTo(remainingLabel.snp.bottom)
            maker.left.equalTo(progressview.snp.right).offset(5)
            maker.bottom.equalToSuperview()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateCellForRowAtIndexPath(_ indexPath : IndexPath, downloadModel: MZDownloadModel) {
        
        titlelabel.text = downloadModel.fileName
        remainingLabel.text = "\((Double(downloadModel.progress)*1000).rounded()/10)% - \(downloadModel.downloadedFile?.size.roundTo() ?? "0") \(downloadModel.downloadedFile?.unit ?? "KB") of \(downloadModel.file?.size.roundTo() ?? "0") \(downloadModel.file?.unit ?? "KB")"
        speedLabel.text = "\(downloadModel.speed?.speed.roundTo() ?? "0") \(downloadModel.speed?.unit ?? "KB")/s - \(downloadModel.remainingTime?.hours ?? 0) houre(s) and \(downloadModel.remainingTime?.minutes ?? 0) remaining"
        progressview.value = CGFloat(downloadModel.progress) * 100
    }
    
    
}
