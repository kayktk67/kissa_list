//
//  DOrderListViewController.swift
//  kissa_list
//
//  Created by Kei Kawamura on 2018/09/20.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DOrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    // インスタンス変数
    var DBRef:DatabaseReference!
    var hogearray : [String] = []
    var array1 : [String] = []
    var d1amount = Array(repeating: "0", count: 20)
    var d3amount = Array(repeating: "0", count: 20)
    var d4amount = Array(repeating: "0", count: 20)
    var dx1amount = Array(repeating: "0", count: 20)
    var dx2amount = Array(repeating: "0", count: 20)
    var dx3amount = Array(repeating: "0", count: 20)
    var dx4amount = Array(repeating: "0", count: 20)
    var nowrow : String?
    var status : String?
    
    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hogearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let tablelabel = cell.contentView.viewWithTag(1) as! UILabel
        let d1label = cell.contentView.viewWithTag(2) as! UILabel
        let d3label = cell.contentView.viewWithTag(3) as! UILabel
        let d4label = cell.contentView.viewWithTag(4) as! UILabel
        let dx1label = cell.contentView.viewWithTag(5) as! UILabel
        let dx2label = cell.contentView.viewWithTag(6) as! UILabel
        let dx3label = cell.contentView.viewWithTag(7) as! UILabel
        let dx4label = cell.contentView.viewWithTag(8) as! UILabel
        
        var status1 : String?
        var intstatus1 : Int?
        let defaultPlacex = DBRef.child("table/dstatus").child(hogearray[indexPath.row])
        defaultPlacex.observe(.value) { (snap: DataSnapshot) in status1 = (snap.value! as AnyObject).description
            intstatus1 = Int(status1!)
            if intstatus1! == 1||intstatus1! == 2{
                cell.contentView.backgroundColor = UIColor.cyan
            }else{
                cell.contentView.backgroundColor = UIColor.clear
            }
        }
        
        let defaultPlace = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("d1amount")
        defaultPlace.observe(.value) { (snap: DataSnapshot) in self.d1amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace2 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("d3amount")
        defaultPlace2.observe(.value) { (snap: DataSnapshot) in self.d3amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace3 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("d4amount")
        defaultPlace3.observe(.value) { (snap: DataSnapshot) in self.d4amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace4 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("dx1amount")
        defaultPlace4.observe(.value) { (snap: DataSnapshot) in self.dx1amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace5 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("dx2amount")
        defaultPlace5.observe(.value) { (snap: DataSnapshot) in self.dx2amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace6 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("dx3amount")
        defaultPlace6.observe(.value) { (snap: DataSnapshot) in self.dx3amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace7 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("dx4amount")
        defaultPlace7.observe(.value) { (snap: DataSnapshot) in self.dx4amount[indexPath.row] = (snap.value! as AnyObject).description}
        
        
        tablelabel.text = "\(String(describing:self.hogearray[indexPath.row]))"
        d1label.text =  "\(String(describing:self.d1amount[indexPath.row]))"
        d3label.text =  "\(String(describing:self.d3amount[indexPath.row]))"
        d4label.text =  "\(String(describing:self.d4amount[indexPath.row]))"
        dx1label.text =  "\(String(describing:self.dx1amount[indexPath.row]))"
        dx2label.text =  "\(String(describing:self.dx2amount[indexPath.row]))"
        dx3label.text =  "\(String(describing:self.dx3amount[indexPath.row]))"
        dx4label.text =  "\(String(describing:self.dx4amount[indexPath.row]))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.nowrow = hogearray[indexPath.row]
        let alertController = UIAlertController(title: "調理済み",message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            let defaultPlace = self.DBRef.child("table/status").child(self.nowrow!)
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in self.status = (snapshot.value! as AnyObject).description
                self.DBRef.child("table/dstatus").child(self.nowrow!).setValue(1)
                self.DBRef.child("table/dxstatus").child(self.nowrow!).setValue(1)
                if self.status == "0" || self.status == "1"{
                    self.DBRef.child("table/status").child(self.nowrow!).setValue(2)
                }
            })
        }
        
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        present(alertController,animated: true,completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()
        //オーダーリストの取得
        let defaultPlace = DBRef.child("table/orderorder")
        defaultPlace.observe(.value, with: { snapshot in
            var array: [String] = []
            for item in (snapshot.children) {
                let snapshot = item as! DataSnapshot
                let dict = snapshot.value as! String
                if Int(dict)!<100{
                    array.append(dict)
                }
            }
            DispatchQueue.main.async {
                self.hogearray = array
            }
        })
        
        Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(self.newArray(_:)),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func newArray(_ sender: Timer) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
