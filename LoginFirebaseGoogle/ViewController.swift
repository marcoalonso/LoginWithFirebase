//
//  ViewController.swift
//  LoginFirebaseGoogle
//
//  Created by marco rodriguez on 22/08/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var correoUsuario: UITextField!
    @IBOutlet weak var contraseñaUsuario: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginButton(_ sender: UIButton) {
        if let email = correoUsuario.text, let password = contraseñaUsuario.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                //validar si hubo error o no
                if error != nil {
                    print("Error al iniciar sesion \(error?.localizedDescription)")
                    
                    let alerta = UIAlertController(title: "ATENCION", message: "Error: \(error!.localizedDescription)", preferredStyle: .alert)
                    let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
                        //navegue al Home
                        print("Go to Home")
                    }
                    alerta.addAction(accionAceptar)
                    self?.present(alerta, animated: true, completion: nil)
                    
                } else {
                    print("Login Exitoso! :) ")
                    self?.performSegue(withIdentifier: "loginHome", sender: self)
                }
            }
        }
        
        /*
         The password is invalid or the user does not have a password.
         There is no user record corresponding to this identifier. The user may have been deleted.
         The email address is badly formatted.
         */
    }
    

}

