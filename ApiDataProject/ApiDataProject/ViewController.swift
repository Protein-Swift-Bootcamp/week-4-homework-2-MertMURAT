//
//  ViewController.swift
//  ApiDataProject
//
//  Created by Mert Murat on 8.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var data = [ToDo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Method Calling
        
        fetchingAPIData(URL: "https://api.opendota.com/api/heroStats") { result in
            self.data = result
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        
        
    }


    func fetchingAPIData(URL url:String, completion: @escaping ([ToDo]) -> Void){
        
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            do{
                let parsingData = try JSONDecoder().decode([ToDo].self, from: data!)
                completion(parsingData)
            }catch{
                print("Parsing Error")
            }
            
        }
       
        
        dataTask.resume()
    }
    
    
}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let apiData: ToDo
        apiData = data[indexPath.row]
        let string = "https://api.opendota.com" + (apiData.img)
        let url = URL(string: string)
        cell.apiImage.downloaded(from: url!, contentMode: .scaleToFill)
        cell.apiLabel.text = apiData.localized_name // "localized_name" alanını geniş ad tanımı için "name" ile değiştirebilirsin.
        
        
        return cell
    }
    
}



// DownLoad API Image
extension UIImageView{
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit){
        contentMode = mode
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard
                let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else{ return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit){
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}




