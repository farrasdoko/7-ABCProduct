//
//  TableViewController.swift
//  ABCProduct
//
//  Created by Gw on 08/11/17.
//  Copyright © 2017 Gw. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let studentURL = "https://script.googleusercontent.com/macros/echo?user_content_key=ChkQqh1Tpu_vjEpiK1CvJadUm8anIrTjpz1KAEciyCBiUuDKd_1NJaWFgF3rdWlL_svdnAdKY_xPYDRTXdofMLsiByhD9WGLOJmA1Yb3SEsKFZqtv3DaNYcMrmhZHmUMWojr9NvTBuB6lHT6qnqYcmFWggwoSVQQy1I5Bo9qCEkCzCDqo9woNJdb-TW_oskRAvMiLJmfu8uHcCUBLJV6YgIO_Ew8o_0imBB_KEA6gBFJTkuTqaPWp36w6lqZ9_xTy2bHR3CakFrc_ScPTHfLrg&lib=MUBVDLa2DH4xDzprwWT1Nz4v1P8nYvko1"
    var student = [ABC]()
    var titleSelected:String?
    var nomor_sertifikatSelected:String?
    var produsenSelected:String?
    var berlaku_hinggaSelected:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStudentsData()
        
        //set row height to 92
        tableView.estimatedRowHeight = 92.0
        //set row table height to automatic dimension
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return student.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.labeltitle.text = student[indexPath.row].title
        cell.labelnomor_sertifikat.text = student[indexPath.row].nomor_sertifikat
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        let dataTask = student[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        titleSelected = dataTask.title
        nomor_sertifikatSelected = dataTask.nomor_sertifikat
        produsenSelected = dataTask.produsen
        berlaku_hinggaSelected = dataTask.berlaku_hingga
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "segue"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let sendData = segue.destination as! ViewController
            sendData.passtitle = titleSelected
            sendData.passnomor_sertifikat = nomor_sertifikatSelected
            sendData.passprodusen = produsenSelected
            sendData.passberlaku_hingga = berlaku_hinggaSelected
        }
    }
    func getStudentsData() {
        guard let studentsURL = URL(string: studentURL) else {
            return //this return is for back up the value that got when call variable loanURL
        }
        let request = URLRequest(url: studentsURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                //condition when error
                //print error
                print(error)
                return //back up value error that we get
            }
            //parse JSON data
            //declare variable data to call data
            if let data = data {
                //for this part will call method parseJsonData that we will make in below
                self.student = self.parseJsonData(data: data)
                
                //reload tableView
                OperationQueue.main.addOperation({
                    //reload data again
                    self.tableView.reloadData()
                })
            }
        })
        //task will resume to call the json data
        task.resume()
    }
    func parseJsonData(data: Data) -> [ABC] {
        var student = [ABC]()
        do{
            //declare jsonResult for take data from the json
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            //parse json data
            //declare jsonLoans for call data array jsonResult with name Loans
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            //will call data be repeated for jsonLoan have data json array from variable jsonLoans
            for jsonLoan in jsonLoans {
                //declare loan as object from class loan
                let studentss = ABC()
                studentss.title = jsonLoan["title"] as! String
                studentss.nomor_sertifikat = jsonLoan["nomor_sertifikat"] as! String
                studentss.produsen = jsonLoan["produsen"] as! String
                studentss.berlaku_hingga = jsonLoan["berlaku_hingga"] as! String
                
                student.append(studentss)
            }
        }catch{
            print(error)
        }
        return student
    }
}
