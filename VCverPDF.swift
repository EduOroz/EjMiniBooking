//
//  VCverPDF.swift
//  MiniBooking
//
//  Created by user125877 on 2/5/17.
//  Copyright © 2017 user125877. All rights reserved.
//

import UIKit

class VCverPDF: UIViewController {

    @IBOutlet weak var webViewPDF: UIWebView!
    var nombrePdfRecibido:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(nombrePdfRecibido)
        mostrarPdf()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mostrarPdf(){
        //1: Direccion del archivo pdf
        let direccionPdf = URL(fileURLWithPath: Bundle.main.path(forResource: nombrePdfRecibido, ofType: "pdf", inDirectory: "PDF")!)
        
        //2:Transformar archivo pdf a Data
        let datosPdf = try? Data(contentsOf: direccionPdf )
        
        //3:Mostrar Datos en el Vista Web
        webViewPDF.load(datosPdf!, mimeType: "application/pdf", textEncodingName: "utf-8", baseURL: direccionPdf)
        
        
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
