//
//  TVCMisReservas.swift
//  MiniBooking
//
//  Created by user125877 on 27/4/17.
//  Copyright © 2017 user125877. All rights reserved.
//

import UIKit

class TVCMisReservas: UITableViewController {

    var usuario: String = ""
    var datosPlist: NSDictionary?
    
    @IBOutlet var tablaMisReservas: UITableView!
    var reservas: [Reserva] = []
    var reserva: Reserva = Reserva()
    
    //Definimos el espacio entre sectiones de 5 puntos
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Recuperamos el usuario en el fichero Configuracion.plist
        let pathPlist = Bundle.main.path(forResource: "Configuracion", ofType: "plist")
        //Cogemos los contenidos del fichero
        datosPlist = NSDictionary(contentsOfFile: pathPlist!)!
        usuario = datosPlist?.value(forKey: "usuario") as! String
        print("El Usuario es: \(usuario)")
        
        //Recuperamos las 2 ultimas reservas de la BD
        let urlCompleto = "http://minionsdesapps.esy.es/apps/verReservas.php?&usuario=\(usuario)"
        
        let objetoUrl = URL(string:urlCompleto)
        let tarea = URLSession.shared.dataTask(with: objetoUrl!) { (datos, respuesta, error) in
            if error != nil {
                print(error!)
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [Any]
                    print(json.description)
                    for jsonReserva in json {
                        let jsonString = jsonReserva as! [String:Any]
                        self.reserva = Reserva(json: jsonString)
                        print(self.reserva.nombre_usuario)
                        self.reservas.append(self.reserva)
                    }
                    
                    DispatchQueue.main.sync(execute: {
                         self.tablaMisReservas.reloadData()
                    })
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
        return reservas.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMisReservas", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = reservas[indexPath.row].nombre_hotel
        

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
