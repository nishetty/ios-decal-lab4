//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! CustomTableViewCell
        let pokemonObject: Pokemon = pokemonArray![indexPath.row]
        cell.tableName.text = pokemonObject.name
        var attack = String(pokemonObject.attack)
        var defense = String(pokemonObject.defense)
        var health = String(pokemonObject.health)
        cell.tableStats.text = attack + "/" + defense + "/" + health
        cell.tableNumber.text = String(pokemonObject.number)
        
        if let image = cachedImages[indexPath.row] {
            cell.tableImage.image = image // may need to change this!
        } else {
            let url = URL(string: (pokemonArray?[indexPath.row].imageUrl)!)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            cell.tableImage.image = UIImage(data: imageData) // may need to change this!
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var pokeObject = pokemonArray![indexPath.row]
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "categoryToInfo", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifer = segue.identifier{
            if identifer == "categoryToInfo"{
                if let vc = segue.destination as? PokemonInfoViewController{
                    vc.pokemon = pokemonArray?[(selectedIndexPath?.row)!]
                    vc.image = cachedImages[(selectedIndexPath?.row)!]
                }
        }
        }
        
            
        
    }

}
