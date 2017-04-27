//
//  VCFormularioReserva.swift
//  MiniBooking
//
//  Created by user125877 on 27/4/17.
//  Copyright © 2017 user125877. All rights reserved.
//

import UIKit

class VCFormularioReserva: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfFecha: UITextField!
    @IBOutlet weak var tfNHabitaciones: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickRegistrar(_ sender: UIButton) {
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
