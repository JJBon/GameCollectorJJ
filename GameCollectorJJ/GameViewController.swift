//
//  GameViewController.swift
//  GameCollectorJJ
//
//  Created by JuanJ on 5/15/17.
//  Copyright © 2017 JJB. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var game:Game? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        imagePicker.delegate = self
        if game != nil {
            gameImageView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true 
        }
    
    }

    @IBAction func photosTapped(_ sender: Any) {
        
        //image picker setup
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        gameImageView.image = image
        
        //importante pero no es claro el porque 
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        //nueva parte , refrescando el core data 
        
        if self.game != nil {
            self.game!.title = titleTextField.text
            
            // asignar imagen como NSData, puede ser como jpeg o pngr
            
            self.game!.image = UIImagePNGRepresentation(gameImageView.image!)! as NSData
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let game = Game(context: context)
            game.title = titleTextField.text
            
            // asignar imagen como NSData, puede ser como jpeg o pngr
            
            game.image = UIImagePNGRepresentation(gameImageView.image!)! as NSData
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        
        
        //core data
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let game = Game(context: context)
        game.title = titleTextField.text

        // asignar imagen como NSData, puede ser como jpeg o pngr
        
        game.image = UIImagePNGRepresentation(gameImageView.image!)! as NSData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    
    @IBAction func deleteTapped(_ sender: Any) {
        
        //solo funciona si no está hidden por ende no hay nil 
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
   }
