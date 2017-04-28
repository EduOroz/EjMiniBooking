//
//  ViewController.swift
//  MiniBooking
//
//  Created by user125877 on 27/4/17.
//  Copyright © 2017 user125877. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbReserva1: UILabel!
    @IBOutlet weak var lbReserva2: UILabel!
    
    var usuario: String = ""
    var datosPlist: NSDictionary?
    
    var hoteles: [Hotel] =  []
    var hotel: Hotel = Hotel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Recuperamos el usuario en el fichero Configuracion.plist
        let pathPlist = Bundle.main.path(forResource: "Configuracion", ofType: "plist")
        //Cogemos los contenidos del fichero
        datosPlist = NSDictionary(contentsOfFile: pathPlist!)!
        usuario = datosPlist?.value(forKey: "usuario") as! String
        print("El Usuario es: \(usuario)")
        
        //Recuperamos las 2 ultimas reservas de la BD
        let urlCompleto = "http://minionsdesapps.esy.es/apps/verReservas.php?&usuario=all"
        
        let objetoUrl = URL(string:urlCompleto)
        let tarea = URLSession.shared.dataTask(with: objetoUrl!) { (datos, respuesta, error) in
            if error != nil {
                print(error!)
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [Any]
                    print(json.description)
                    for jsonHotel in json {
                        let jsonString = jsonHotel as! [String:Any]
                        self.hotel = Hotel(json: jsonString)
                        print(self.hotel.nombre)
                        self.hoteles.append(self.hotel)
                    }
                    
                    DispatchQueue.main.sync(execute: {
                        self.lbReserva1.text = self.hoteles[0].nombre
                        self.lbReserva2.text = self.hoteles[1].nombre
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


}

