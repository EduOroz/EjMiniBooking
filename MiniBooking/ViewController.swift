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
    
    var reservas: [Reserva] = []
    var reserva: Reserva = Reserva()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Configuramos las labels
        self.lbReserva1.numberOfLines=0
        self.lbReserva2.numberOfLines=0
        self.lbReserva1.lineBreakMode = .byWordWrapping
        self.lbReserva2.lineBreakMode = .byWordWrapping
        
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
                    for jsonReserva in json {
                        let jsonString = jsonReserva as! [String:Any]
                        self.reserva = Reserva(json: jsonString)
                        print(self.reserva.nombre_usuario)
                        self.reservas.append(self.reserva)
                    }
                    
                    DispatchQueue.main.sync(execute: {
                        self.lbReserva1.text = " Usuario \(self.reservas[0].nombre_usuario) ha reservado \(self.reservas[0].numero_habitaciones) habitaciones en el hotel \(self.reservas[0].nombre_hotel) el día \(self.reservas[0].fecha_reserva)"
                        self.lbReserva2.text = " Usuario \(self.reservas[1].nombre_usuario) ha reservado \(self.reservas[1].numero_habitaciones) habitaciones en el hotel \(self.reservas[1].nombre_hotel) el día \(self.reservas[1].fecha_reserva)"
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

