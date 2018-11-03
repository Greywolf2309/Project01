//
//  ViewController.swift
//  Project_1
//
//  Created by Tu Doan on 02/11/2018.
//  Copyright © 2018 DoanVantu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    let fbloginmanager:FBSDKLoginManager = FBSDKLoginManager()
    
    @IBAction func AbtnLoginFB(_ sender: Any) {
        login()
    }
    //facebook
    func login() {
        fbloginmanager.logIn(withReadPermissions: ["email"], from: self) { (result, err)
            in
            if(err == nil) {
                print("Dang nhap thanh cong")
                let fbloginresult:FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil{
                    self.getdata()
                }
            } else {
                print("Dang nhap that bai")
            }
        }
    }
    func getdata() {
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name"]).start(completionHandler: { (connect, resuslt, err) in
                if err == nil {
                    let dict = resuslt as! Dictionary<String,Any>
                    print(dict)
                }
            })
        }
    }

    //google
    
    @IBAction func AbtnLoginGG(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {

    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

    //viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

