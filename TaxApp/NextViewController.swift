//
//  NextViewController.swift
//  TaxApp
//
//  Created by 杉浦陽樹 on 2022/10/27.
//

import UIKit

class NextViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sum = UserDefaults.standard.array(forKey: "num") as! [Float]
        label.text = "\(sum.reduce(0, +))"
        print(sum)
    }

}
