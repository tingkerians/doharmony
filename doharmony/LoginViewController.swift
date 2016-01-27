//
//  LoginViewController.swift
//  doharmony
//
//  Created by khemer sone andres on 1/25/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    Send a login request to the server
    */
    @IBAction func loginTapped(sender: UIButton) {
        
        let username = usernameTextField.text!;
        let password = passwordTextField.text!;
        
        let serverURL = "http://192.168.0.112/api/login";
        
        if (username.isEmpty || password.isEmpty) {
            let message = "Username and password should not be empty";
            self.showAlert("Alert", message: message);
            return;
        }
        
        let parameters = [
            "username" : username,
            "password" : password
        ];
        
        
        Alamofire.request(.POST, serverURL	, parameters: parameters, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let result = JSON(response.result.value!);
                    print("JSON RESPONSE VALUE:\n\(result)");
                    self.saveToken(parameters["username"]!, token: result["token"].stringValue);
                    self.showAlert("Login Success", message: result["token"].stringValue); //
                    print("STATUS CODE:\(response.response?.statusCode)");
                    self.displayAllToken(); //
                    
                case .Failure(let error):
                    print("HTTP RESPONSE: \n\(response.response)"); //
                    print("STATUS CODE:\(response.response?.statusCode)");
                    self.showAlert("Login failed", message: String(error.localizedDescription));
                }
        }
    }
    
    /*
    Used to show login alerts/message on the login screen
    */
    func showAlert(title: String, message: String) {
        var msg: String = message;
        let invalidCredentialRegex = "422";
        
        // checks if message contains "422" status code, set the message to 'Incorrect username or password'
        if let _ = message.rangeOfString(invalidCredentialRegex, options: .RegularExpressionSearch) {
            msg = "Incorrect username or password";
        }
        let alert = UIAlertController(title: title,
            message: msg, preferredStyle: .Alert);
        let action = UIAlertAction(title: "Close", style: .Default, handler: nil);
        
        alert.addAction(action);
        
        self.presentViewController(alert, animated: true, completion: nil);
        return;
    }
    
    /*
    Save the tokens that is given to the user into the app
    */
    func saveToken(username: String, token: String) {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        
        let user = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context);
        user.setValue(username, forKey: "username");
        user.setValue(token, forKey: "token");
        
        do {
            try context.save();
            print("TOKEN SAVED:\n\(user)");
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)");
        }
        
    }
    
    /*
    (For debugging purposes)
    Displays all token per user that is stored in the device
    */
    func displayAllToken() {
        print("DISPLAYING ALL STORED TOKENS (w/ username):\n");
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        
        let request = NSFetchRequest(entityName: "Users");
        let entityDescription = NSEntityDescription.entityForName("Users", inManagedObjectContext: context);
        
        request.entity = entityDescription;
        // uncomment if searching for a specific token
        //        request.predicate = NSPredicate(format: "username = %@", usernameTextField.text!);
        
        do {
            let result: NSArray = try context.executeFetchRequest(request);
            print(result);
            let user = result as! [NSManagedObject];
            for u in user {
                print("username:\(u.valueForKey("username")!)");
                print("token:\(u.valueForKey("token")!)\n");
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }
    }
    
    /*
    (For logout function)
    Used to delete or destroy the user's token stored in the app
    */
    func unsetToken(username: String) {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        
        let request = NSFetchRequest(entityName: "Users");
        request.predicate = NSPredicate(format: "username = %@", "username");
        
        do {
            let fetched = try context.executeFetchRequest(request);
            if let entityToDelete = fetched.first {
                context.deleteObject(entityToDelete as! NSManagedObject);
            }
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)");
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
