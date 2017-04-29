//
//  VCFormularioReserva.swift
//  MiniBooking
//
//  Created by user125877 on 27/4/17.
//  Copyright © 2017 user125877. All rights reserved.
//

import UIKit

class VCFormularioReserva: UIViewController {

    @IBOutlet weak var lbNombre_hotel: UILabel!
    @IBOutlet weak var tfFecha: UITextField!
    @IBOutlet weak var tfNHabitaciones: UITextField!
    
    var hotel: Hotel = Hotel()
    var usuario: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbNombre_hotel.text = hotel.nombre
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickRegistrar(_ sender: UIButton) {
        
        if (lbNombre_hotel.text==""){
            mostrarAlerta(titulo: "Faltan Datos", texto: "Error al incluir el nombre del Hotel vuelva atrás")
        } else {
            if (tfFecha.text==""){
                mostrarAlerta(titulo: "Faltan Datos", texto: "Falta indicar la fecha de la reserva")
            } else {
                if (tfNHabitaciones.text==""){
                    mostrarAlerta(titulo: "Faltan Datos", texto: "Falta indicar el numero de habitaciones")
                } else {
                    //Comprobar las habitaciones libres sean mas que las solicitadas
                    if (Int(tfNHabitaciones.text!)! > hotel.habitaciones_libres){
                        mostrarAlerta(titulo: "Lo lamentamos", texto: "No tenemos tantas habitaciones disponibles")
                        print(tfNHabitaciones.text!)
                        print(hotel.habitaciones_libres)
                    } else {
                        //Realizar la reserva
                        realizarReserva()
                    }
                    
                }
            }
        }
    }
    
    func realizarReserva(){
        
        //Falta que en el php se controle que nadie nos ha quitado una habitación en el último momento y controlar ese error devuelto por el php con un código concreto
        
        let urlCompleto = "http://minionsdesapps.esy.es/apps/insertReserva.php?id_hotel=\(hotel.id)&fecha=\(tfFecha.text!)&habitaciones=\(tfNHabitaciones.text!)&usuario=\(usuario)"
        print(urlCompleto)
        let objetoUrl = URL(string:urlCompleto)
        let tarea = URLSession.shared.dataTask(with: objetoUrl!) { (datos, respuesta, error) in
            if error != nil {
                print(error!)
            } else {
                if let usableData = datos {
                    print("usableData: \(usableData)")
                    print("usableData.description: \(usableData.description)")
                    let string = String(data: datos!, encoding: String.Encoding.utf8)
                    print(string!) //JSONSerialization
                    if string=="1" {
                        print("Registro insertado en la BD")
                        self.mostrarAlertaInicio(titulo: "Reserva realizada", texto: "Se ha realizado la reserva solicitada")
                    } else {
                        print("No se ha podido realizar la reserva, error sql \(String(describing: string))")
                    }
                } else {
                    print("No se ha podido realizar la reserva, error en datos")
                }
                
            }
            
        }
        
        tarea.resume()
    
    }
    
    func mostrarAlerta (titulo:String, texto: String ){
        //Creamos una alerta
        let alerta = UIAlertController(title: titulo, message: texto, preferredStyle: UIAlertControllerStyle.alert)
        
        let volver = UIAlertAction(title: "Volver", style: UIAlertActionStyle.default, handler: { alertAction in
            ()
            alerta.dismiss(animated: true, completion: nil)
        })
        
        alerta.addAction(volver)
        
        //Mostramos la alerta en nuestra vista
        self.present(alerta, animated: true, completion: nil)
        
    }
    
    func mostrarAlertaInicio (titulo:String, texto: String ){
        //Creamos una alerta
        let alerta = UIAlertController(title: titulo, message: texto, preferredStyle: UIAlertControllerStyle.alert)
        
        let volver = UIAlertAction(title: "Volver", style: UIAlertActionStyle.default, handler: { alertAction in
            ()
            self.performSegue(withIdentifier: "SegueFromFormularioToInicio", sender: nil)
            
        })
        
        alerta.addAction(volver)
        
        //Mostramos la alerta en nuestra vista
        self.present(alerta, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

// Para que al clickar fuera del teclado este desaparezca
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
