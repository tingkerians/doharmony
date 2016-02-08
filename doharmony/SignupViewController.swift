//
//  SignupViewController.swift
//  doharmony
//
//  Created by Mark Bermillo on 04/02/2016.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import CoreData


class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!

    
    // All error messages will be stored here
    var errorMessages = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    Send signup details to the server
    If the signup is successful, server returns a token
    and the user should be automatically logged in

    Note: Will rewrite the code later
    */
    @IBAction func singupTapped(sender: UIButton) {
//        let serverURL = "http://192.168.0.137/api/register"; // Local server
        let serverURL = "http://192.168.0.138:8080/users/users"; // Mac server
        
        // Initialize the 'errorMessages' array
        errorMessages = [String]();
        
        // Text fields references
        let firstName = firstNameTextField.text!;
        let lastName = lastNameTextField.text!;
        let email = emailTextField.text!;
        let username = usernameTextField.text!;
        let password = passwordTextField.text!;
        let retype = retypePasswordTextField.text!;
        
        // Prompt the user if there are any blank fields
        if (firstName.isEmpty || lastName.isEmpty ||
            email.isEmpty || username.isEmpty ||
            password.isEmpty || retype.isEmpty) {
                self.showAlert("Alert", message: "All fields are required");
                return;
        }
        
        // Validates the form
        validateAllInput();
        
        // Prompt the user for validation errors (delete later)
        if errorMessages.count > 0 {
            showAlert("Validation Error", message: errorMessages.first!);
            return;
        }
        
        // Set the text field values as parameters for the signup request
        let parameters = [
            "first_name" : firstName,
            "last_name" : lastName,
            "email" : email,
            "username" : username,
            "password" : password
        ];
        
        // Send POST http request to the server
        Alamofire.request(.POST, serverURL, parameters:parameters, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                    // Status code == 200...299
                case .Success:
                    let result = JSON(response.result.value!);
                    print(result); // delete later
                    print("HTTP RESPONSE:\n\(response.response)"); // delete later
                    
                    // Save the token, the user should already be logged in after this
                    self.saveToken(parameters["username"]!, token: result["token"].stringValue);
                    // Insert redirect to home page here
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("RevealViewController") as UIViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                    // Status code == 400...499
                case .Failure(let error):
                    print("HTTP RESPONSE:\n\(response.response)");
                    self.showAlert("Signup failed", message: String(error.localizedDescription));
                    return;
                }
        }
        
        return;
    }
    
    /*
    Validate the sign up details
    */
    func validateAllInput() {
        // Validation Rules
        let noSpaces = "\\s";
        let noDigits = ".*[0-9]+.*";
        let emailAddress = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z??]{2,})$";
        //let containsCapital = "^.*?[A-Z].*?$";
        let usernameLength = "^[a-zA-Z0-9]{6,24}$";
        let alphanumeric = "^(?=.*\\d)(?=.*[a-zA-Z])(?!.*[\\W_\\x7B-\\xFF])$";
        
        // Validation Error Messages
        let noSpacesError = "There should be no spaces";
        let noDigitsError = "This should not contain numbers";
        let emailAddressError = "Invalid email";
        let lengthError = "Length should be between 6 and 24";
        let alphanumericError = "Should only contain alphanumeric characters";
        
        // Validation
        // First Name
        validateText(firstNameTextField, isExclusive: false, rule: noDigits, errorMessage: noDigitsError);
        
        // Last Name
        validateText(lastNameTextField, isExclusive: false, rule: noDigits, errorMessage: noDigitsError);
        
        // Email
        validateText(emailTextField, isExclusive: false, rule: noSpaces, errorMessage: noSpacesError);
        validateText(emailTextField, isExclusive: true, rule: emailAddress, errorMessage: emailAddressError);
        
        // Username
        validateText(usernameTextField, isExclusive: false, rule: noSpaces, errorMessage: noSpacesError);
        validateText(usernameTextField, isExclusive: true, rule: usernameLength, errorMessage: lengthError);
        
        // Password
        validateText(passwordTextField, isExclusive: false, rule: noSpaces, errorMessage: noSpacesError);
        validateText(passwordTextField, isExclusive: true, rule: usernameLength, errorMessage: lengthError);
        validateText(passwordTextField, isExclusive: false, rule: alphanumeric, errorMessage: alphanumericError);
        
        // Retype password
        validateText(retypePasswordTextField, isExclusive: false, rule: noSpaces, errorMessage: noSpacesError);
        
        // Prompt the user if the password and retype password value does not match
        if passwordTextField.text != retypePasswordTextField.text {
            errorMessages.append("Password and retype password don't match");
            toggleBorderColor(passwordTextField, isValid: false); // Change password border color to red
            toggleBorderColor(retypePasswordTextField, isValid: false); // Change retype password border color to red
        }
        
        return;
    }
    
    /*
    textfield - textfield to be validated
    rule - rule to be check against
    errorMessage - error message if validation failed
    
    Validates the field against the parameter 'rule',
    and change textfield's border color if the validation failed.
    
    Adds the message to the 'errorMessages' array, and
    change the textfield's border if there are any
    validation errors.
    */
    func validateText(textField: UITextField, isExclusive: Bool, rule: String, errorMessage: String) {
        
        // Check the string value of the field if it matches the regex
        if let _ = textField.text!.rangeOfString(rule, options: .RegularExpressionSearch) {
            
            // If the given text should not match regex rule
            if isExclusive {
                toggleBorderColor(textField, isValid: true); // Change border color to transparent
                return;
            }
            // Add the errorMessage to the erroMessages array
            errorMessages.append(errorMessage);
            toggleBorderColor(textField, isValid: false) // Change border color to red
            
        } else {
            // If the given text should not match regex rule
            if isExclusive {
                // Add the errorMessage to the erroMessages array
                errorMessages.append(errorMessage);
                toggleBorderColor(textField, isValid: false); // Change border color to red
                return;
            }
            toggleBorderColor(textField, isValid: true); // Change border color to transparent
        }
        
        return;
    }
    
    /*
    textfield - textfield that will be updated
    isValid - sets the textfield's border color to red if given a 'false' value
    
    Toggle text fields' border color (red and transparent)
    */
    func toggleBorderColor(textField: UITextField, isValid: Bool) {
        let valid : UIColor = UIColor( red: 0, green: 0, blue:0 , alpha: 0 ); // Transparent
        let invalid: UIColor = UIColor( red: 1, green: 0, blue:0, alpha: 1.0 ); // Red color
        
        textField.layer.borderWidth = 1; // Minimum borderwidth value for the border color to be seen
        
        if isValid {
            textField.layer.borderColor = valid.CGColor;
        } else {
            textField.layer.borderColor = invalid.CGColor;
        }
        
        return;
    }
    
    /*
    Used to show alerts and message
    */
    func showAlert(title: String, message: String) {
        var msg: String = message;
        let invalidCredentialRegex = "409";
        
        /*
        checks if message contains "409" status code,
        set the alert message to 'Username is already taken'
        */
        if let _ = message.rangeOfString(invalidCredentialRegex,
            options: .RegularExpressionSearch) {
                msg = "Username/Email is already taken";
                toggleBorderColor(usernameTextField, isValid: false);
        }
        let alert = UIAlertController(title: title,
            message: msg, preferredStyle: .Alert);
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil);
        
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
        return;
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