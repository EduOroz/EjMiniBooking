//
//  Reserva.swift
//  MiniBooking
//
//  Created by xBako on 29/04/2017.
//  Copyright © 2017 user125877. All rights reserved.
//

import Foundation

class Reserva: NSObject {
    var nombre_usuario: String
    var nombre_hotel: String
    var numero_habitaciones: Int
    var fecha_reserva: String
    var nombre_imagen: String
    
    override init() {
        self.nombre_hotel=""
        self.nombre_usuario=""
        self.numero_habitaciones=0
        self.fecha_reserva=""
        self.nombre_imagen=""
    }
    
    init(json: [String: Any]) {
        self.nombre_hotel = (json["nombre"] as? String)!
        self.nombre_usuario = (json["nombre_usuario"] as? String)!
        self.numero_habitaciones = Int((json["numero_habitaciones"] as? String)!)!
        self.fecha_reserva = (json["fecha_reserva"] as? String)!
        self.nombre_imagen = (json["nombre_imagen"] as? String)!
    }
}
