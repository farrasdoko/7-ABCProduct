//
//  ViewController.swift
//  ABCProduct
//
//  Created by Gw on 08/11/17.
//  Copyright © 2017 Gw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblnomor_sertifikat: UILabel!
    @IBOutlet weak var lblprodusen: UILabel!
    @IBOutlet weak var lblberlaku_hingga: UILabel!
    var passtitle:String?
    var passnomor_sertifikat:String?
    var passprodusen:String?
    var passberlaku_hingga:String?
    
    override func viewDidLoad() {
        
        lbltitle.text = passtitle!
        lblnomor_sertifikat.text = passnomor_sertifikat!
        lblprodusen.text = passprodusen!
        lblberlaku_hingga.text = passberlaku_hingga!
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
