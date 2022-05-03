//
//  LocationsListVC.swift
//  CoreDataExample
//
//  Created by Ahmet Mucahid Bozkurt on 2.05.2022.
//

import UIKit
import CoreData

class LocationsListVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var cityNameArray = [String]()
    var idArray = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addBtnClicked))
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc private func addBtnClicked() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationDetailsVC") as? LocationDetailsVC {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    @objc private func getData() {
        cityNameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let cityName = result.value(forKey: Attributes.cityName.rawValue) as? String {
                    cityNameArray.append(cityName)
                }
                
                if let id = result.value(forKey: Attributes.id.rawValue) as? UUID {
                    idArray.append(id)
                }
                
                self.tableView.reloadData()
            }
        } catch {
            print("error")
        }
    }

}

extension LocationsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocaitonTableViewCell") as! LocaitonTableViewCell
        cell.setData(cityName: cityNameArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationDetailsVC") as? LocationDetailsVC {
            viewController.showLocaitonDetails = true
            viewController.selectedLocation = cityNameArray[indexPath.row]
            viewController.selectedLocationID = idArray[indexPath.row]
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
}

