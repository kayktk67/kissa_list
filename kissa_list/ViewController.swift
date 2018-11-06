//
//  ViewController.swift
//  kissa_list
//
//  Created by Kei Kawamura on 2018/09/19.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func ToBOrderList(_ sender: Any) {
        performSegue(withIdentifier: "toborderlist", sender: nil)
    }
    @IBAction func ToBOutOrderList(_ sender: Any) {
        performSegue(withIdentifier: "toboutorderlist", sender: nil)
    }
    @IBAction func ToBOutSubOrderList(_ sender: Any) {
        performSegue(withIdentifier: "toboutsuborderlist", sender: nil)
    }
    @IBAction func ToSOrderList(_ sender: Any) {
        performSegue(withIdentifier: "tosorderlist", sender: nil)
    }
    @IBAction func ToSOutOrderList(_ sender: Any) {
        performSegue(withIdentifier: "tosoutorderlist", sender: nil)
    }
    @IBAction func ToDOrderList(_ sender: Any) {
        performSegue(withIdentifier: "todorderlist", sender: nil)
    }
    @IBAction func ToDXOrderList(_ sender: Any) {
        performSegue(withIdentifier: "todxorderlist", sender: nil)
    }
    @IBAction func ToDeOrderList(_ sender: Any) {
        performSegue(withIdentifier: "todeorderlist", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

