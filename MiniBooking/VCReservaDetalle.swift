//
//  VCReservaDetalle.swift
//  MiniBooking
//
//  Created by user125877 on 27/4/17.
//  Copyright © 2017 user125877. All rights reserved.
//

import UIKit
import MapKit

class VCReservaDetalle: UIViewController {

    @IBOutlet weak var imagenDetalle: UIImageView!
    @IBOutlet weak var webViewURL: UIWebView!
    @IBOutlet weak var mapView: MKMapView!
    
    var reserva: Reserva = Reserva()
    
    //Definimos un radio de lo que veremos y una localizacion inicial
    let regionRadius: CLLocationDistance = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Cargamos la imagen
        imagenDetalle.image = UIImage.init(named: reserva.nombre_imagen)
        
        //Cargamos el webView con la url
        webViewURL.loadHTMLString("<html><body><center><h2>Esto es un WebView para el hotel<h2></center></body></html>", baseURL: nil)
        
        //Cargamos el mapa
        let hotelLocation = CLLocation(latitude: reserva.latitud, longitude: reserva.longitud)
        
        centerMapOnLocation(location: hotelLocation)
        //mostramos una chincheta
        let artwork = Artwork(title: reserva.nombre_hotel,
                              locationName: "Reservadas \(reserva.numero_habitaciones) habitaciones",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: reserva.latitud, longitude: reserva.longitud))
        mapView.addAnnotation(artwork)
        
    }

    func centerMapOnLocation (location: CLLocation){
        //Centramos el mapa según unas coordenadas y una distancia de radio de lo que veremos
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
