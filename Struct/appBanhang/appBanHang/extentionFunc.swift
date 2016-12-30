//
//  extentionFunc.swift
//  appBanHang
//
//  Created by datnguyen on 12/17/16.
//  Copyright © 2016 datnguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func addContrainsWithVS(format:String,views:UIView...){
        var dic:Dictionary<String,Any> = [:]
        for (index,value) in views.enumerated(){
            value.translatesAutoresizingMaskIntoConstraints = false
            dic["v\(index)"] = value
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dic))
    }
}

extension UIImageView{

    func loadImageOnline(link: String){
        let indicator:UIActivityIndicatorView = {
            let indi = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            indi.color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            indi.translatesAutoresizingMaskIntoConstraints = false
            return indi
        }()
        self.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        indicator.startAnimating()
        let queue = DispatchQueue(label: "queue")
        queue.async {
            let url = URL(string: link)
            do {
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    indicator.stopAnimating()
                    indicator.hidesWhenStopped = true
                }
                
            }catch{}
        }
        
    }
}
