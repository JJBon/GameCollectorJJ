//
//  ViewController.swift
//  GameCollectorJJ
//
//  Created by JuanJ on 5/15/17.
//  Copyright © 2017 JJB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var games:[Game] =  []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        //getting stuff out of core data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //need try
        
        do {
            games = try context.fetch(Game.fetchRequest())
            print(games)
            tableView.reloadData()
        } catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let game = games[indexPath.row]
        cell.textLabel?.text = game.title
        cell.imageView?.image = UIImage(data: game.image as! Data)
        return cell
    }
    
    // como mandar datos por un did select usando perform y prepare for segue 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        performSegue(withIdentifier: "gameSegue", sender: game)
    }
    
    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! GameViewController
        nextVC.game = sender as? Game
        
    }


}

