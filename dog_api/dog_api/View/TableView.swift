//
//  ViewController.swift
//  dog_api
//
//  Created by spark-03 on 2024/02/16.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var dogTableView: UITableView!
    
    let dog = Dog()
    var dogResponse: DogResponse?
    
    var breeds: [String] = []
    var selectedBreeds: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dogTableView.delegate = self
        dogTableView.dataSource = self
        
        setBreeds()
    }
    
    func setBreeds(){
        Task {
            let result = await dog.getBreeds()
            switch result {
            case .success(let dogResponse):
                self.dogResponse = dogResponse
                self.breeds = dogResponse.message.keys.sorted()
                dogTableView.reloadData()
            case .failure(let error):
                self.setErrorMessage(alert:"Error\(error.localizedDescription)")
            }
        }
    }
    
    func setErrorMessage(alert: String) {
        Task{
            let alertController = UIAlertController(title: alert, message: "エラー", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            self.present(alertController, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogResponse?.message.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let dogBreeds = breeds[indexPath.row]
        cell.textLabel?.text = dogBreeds
        return cell
        
        /*
        if breeds.indices.contains(indexPath.row) {
         let breed = breeds(indexPath.row)
         cell.textLabel?text = breedd
         }
         return cell
         }
         
        */
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedBreeds = breeds[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "toCollection" {
            if let nextScene = segue.destination as? DogBreedsCollection {
                nextScene.selectedBreed = selectedBreeds
            }
        }
    }
}
