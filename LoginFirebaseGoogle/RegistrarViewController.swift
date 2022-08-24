//
//  RegistrarViewController.swift
//  LoginFirebaseGoogle
//
//  Created by marco rodriguez on 24/08/22.
//

import UIKit
import FirebaseAuth

class RegistrarViewController: UIViewController {

    
    @IBOutlet weak var contraseñaUsuario: UITextField!
    @IBOutlet weak var correoUsuario: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func registrarButton(_ sender: UIButton) {
        if let email = correoUsuario.text, let password = contraseñaUsuario.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("Error al crear usuario en Firebase: \(e.localizedDescription)")
                    /*
                     1.- El correo ya esta en uso
                     2.- El correo esta en un formato invalido
                     3.- La contraseña debe tener 6 o mas caracteres
                     */
                    switch e.localizedDescription {
                    case "The email address is badly formatted.":
                        self.showMSJAlerta(msj: "ERROR AL CREAR USUARIO, El correo esta en un formato invalido! ")
                        
                    case "The email address is already in use by another account.":
                        self.showMSJAlerta(msj: "ERROR AL CREAR USUARIO, El correo ya esta en uso! ")
                        
                    case "The password must be 6 characters long or more.":
                        self.showMSJAlerta(msj: "ERROR AL CREAR USUARIO, La contraseña debe tener 6 o mas caracteres! ")
                    default:
                        print("error desconocido")
                    }
                    //self.showMSJAlerta(msj: "ERROR AL CREAR USUARIO : \(e.localizedDescription)")
                } else {
                    print("Se creó el usuario en Firebase \(authResult?.description)")
                    self.performSegue(withIdentifier: "registroHome", sender: self)
                    
//                    let alerta = UIAlertController(title: "ATENCION", message: "USUARIO CREADO CORRECTAMENTE", preferredStyle: .alert)
//                    let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
//                        //navegue al Home
//                        self.performSegue(withIdentifier: "registroHome", sender: self)
//                    }
//                    alerta.addAction(accionAceptar)
//                    self.present(alerta, animated: true, completion: nil)
                }
            }
        }
    }
    
    func showMSJAlerta(msj: String){
        let alerta = UIAlertController(title: "ATENCION", message: msj, preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
            //navegue al Home
            print("Go to Home")
        }
        alerta.addAction(accionAceptar)
        present(alerta, animated: true, completion: nil)
    }
    
 
    
    
}
