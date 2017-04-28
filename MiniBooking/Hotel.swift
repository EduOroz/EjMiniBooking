//
//  Hotel.swift
//  MiniBooking
//
//  Created by user125877 on 28/4/17.
//  Copyright © 2017 user125877. All rights reserved.
//

import Foundation

class Hotel: NSObject {
    
    var nombre: String
    var latitud: Double
    var longitud: Double
    var habitaciones_libres: Int
    var nombre_imagen: String
    var id: Int
    
    override init() {
        self.nombre = ""
        self.latitud = 0
        self.longitud = 0
        self.habitaciones_libres = 0
        self.nombre_imagen = ""
        self.id = 0
    }
    
    init(nombre:String, latitud:Double, longitud:Double, habitaciones_libres:Int, nombre_imagen:String, id:Int) {
        self.nombre = nombre
        self.latitud = latitud
        self.longitud = longitud
        self.habitaciones_libres = habitaciones_libres
        self.nombre_imagen = nombre_imagen
        self.id = id
    }
    
    init(json: [String: Any]) {
        self.nombre = (json["nombre"] as? String)!
        self.latitud = Double((json["latitud"] as? String)!)!
        self.longitud = Double((json["longitud"] as? String)!)!
        self.habitaciones_libres = Int((json["habitaciones_libres"] as? String)!)!
        self.id = Int((json["id"] as? String)!)!
        self.nombre_imagen = (json["nombre_imagen"] as? String)!
    }
}
