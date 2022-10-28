//
//  ViewController.swift
//  TaxApp
//
//  Created by 杉浦陽樹 on 2022/10/27.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tax: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    
    var num = [Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        guard let Num = UserDefaults.standard.array(forKey: "num") as? [Float] else {return}
        num.append(contentsOf: Num)
    }
    
    @IBAction func add(_ sender: Any) {
        if textField.text != "" && Float(textField.text!) != nil{
            
            if tax.selectedSegmentIndex == 1 {
                let A = Float(textField.text!)! * 1.1
                num.insert(A, at: 0)
                tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
                UserDefaults.standard.set(num, forKey: "num")
            }else {
                let B = Float(textField.text!)! * 1.08
                num.insert(B, at: 0)
                tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
                UserDefaults.standard.set(num, forKey: "num")
            }
        } else {
            let alertController = UIAlertController(title: "数字を入力してください", message: "", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alertController.addAction(ok)
            present(alertController, animated: true, completion: nil)
        }
        textField.text = nil
        label.text = nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        num.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(num[indexPath.row])"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            num.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            UserDefaults.standard.set(num, forKey: "num")
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text != "" && Float(textField.text!) != nil{
            
            if tax.selectedSegmentIndex == 1 {
                label.text = "\(String(describing: (Float(textField.text!))! * 1.1))"
            }else {
                label.text = "\(String(describing: (Float(textField.text!))! * 1.08))"
            }
        }
    }
    
    @IBAction func tax(_ sender: Any) {
        if textField.text != "" && Float(textField.text!) != nil{
            
            if tax.selectedSegmentIndex == 1 {
                label.text = "\(String(describing: (Float(textField.text!))! * 1.1))"
            }else {
                label.text = "\(String(describing: (Float(textField.text!))! * 1.08))"
            }
        }
    }
    
    
}
