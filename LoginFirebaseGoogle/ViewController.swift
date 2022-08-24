//
//  ViewController.swift
//  LoginFirebaseGoogle
//
//  Created by marco rodriguez on 22/08/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var correoUsuario: UITextField!
    @IBOutlet weak var contraseñaUsuario: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificarSesionGuardada()
    }
    
    func verificarSesionGuardada(){
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String {
            print(email)
            //Navegar al Home
            performSegue(withIdentifier: "loginHome", sender: self)
        }
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
    
    
    @IBAction func sigInGoogleButton(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                print("Error al registrar cuenta google: \(error.localizedDescription)")
                return
            }
            
            guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { resultado, error in
                if let loginResultado = resultado, error == nil {
                    print("Inicios de sesion con Google exitoso\(loginResultado)")
                    self.performSegue(withIdentifier: "loginHome", sender: self)
                } else {
                    print("Error al autenticar con Google")
                }
            }
        }
    }
    

}

