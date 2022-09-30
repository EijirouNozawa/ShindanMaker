//
//  LoginViewController.swift
//  Swoft6ShindanMaker1
//
//  Created by 野澤英二郎 on 2021/03/01.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView



class LoginViewController: UIViewController {
    
    var provider:OAuthProvider?
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang":"ja"]
        
        
    
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    
    @IBAction func twitterLogin(_ sender: Any) {
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login":"true"]
        provider?.getCredentialWith(nil, completion: { (credential, error) in
            
            let activityView = NVActivityIndicatorView(frame: self.view.bounds, type: .ballBeat, color: .magenta, padding: .none)
            
            self.view.addSubview(activityView)
            activityView.startAnimating()
            
            Auth.auth().signIn(with: credential!) { (result, error) in
                
                if error != nil{
                    
                    return
                    
                }
                
                activityView.stopAnimating()
                
                
                let viewVC = self.storyboard?.instantiateViewController(identifier: "viewVC") as! ViewController
                
                viewVC.userName = (result?.user.displayName)!
                self.navigationController?.pushViewController(viewVC, animated: true)
                
                
                
            }
            
            
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
