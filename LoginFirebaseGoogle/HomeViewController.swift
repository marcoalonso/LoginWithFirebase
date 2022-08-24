//
//  HomeViewController.swift
//  LoginFirebaseGoogle
//
//  Created by marco rodriguez on 24/08/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guardarSesion()
    }
    func guardarSesion(){
        if let email = Auth.auth().currentUser?.email {
            let defaults = UserDefaults.standard
            defaults.set(email, forKey: "email")
            defaults.synchronize()
        }
    }
    func eliminarSesion(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        print("Se elimino la sesion ")
        defaults.synchronize()
    }
    
    @IBAction func cerrarSesionButton(_ sender: UIButton) {
        do {
          try Auth.auth().signOut()
            print("Sesion finalizada!")
            eliminarSesion()
            //navegar a otro VC
            navigationController?.popToRootViewController(animated: true)
        }catch {
            print("Error al cerrar la sesion: \(error.localizedDescription)")
        }
    }
}
