//
//  TVCCatalogo.swift
//  MiniBooking
//
//  Created by user125877 on 27/4/17.
//  Copyright © 2017 user125877. All rights reserved.
//

import UIKit

class TVCCatalogo: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let urlCompleto = "http://minionsdesapps.esy.es/apps/verHoteles.php"
        
        let objetoUrl = URL(string:urlCompleto)
        let tarea = URLSession.shared.dataTask(with: objetoUrl!) { (datos, respuesta, error) in
            if error != nil {
                print(error!)
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    print(json.description)
                    /*let querySubJson = json["query"] as! [String:Any]
                    //print(querySubJson)
                    let pagesSubJson = querySubJson["pages"] as! [String:Any]
                    //print(pagesSubJson)
                    let pageId = pagesSubJson.keys
                    let primerLlave = pageId.first!
                    let idSubJson = pagesSubJson[primerLlave] as! [String:Any]
                    //let idSubJson = pagesSubJson["23597"] as! [String:Any]
                    //print(idSubJson)
                    let extractStringHtml = idSubJson["extract"] as! String
                    print(extractStringHtml)
                    DispatchQueue.main.sync(execute: {
                        self.webView.loadHTMLString(extractStringHtml, baseURL: nil)
                    })*/
                }catch {
                    
                    print("El Procesamiento del JSON tuvo un error")
                    
                }
                
            }
            
        }
        
        tarea.resume()
        
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
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCatalogo", for: indexPath)

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
