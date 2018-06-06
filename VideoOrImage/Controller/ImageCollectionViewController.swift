//
//  ImageCollectionViewController.swift
//  VideoOrImage
//
//  Created by Anton on 01.06.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

private let reuseIdentifier = "IG"


class ImageCollectionViewController: UICollectionViewController,UITextFieldDelegate,UISearchBarDelegate {
    @IBOutlet weak var surchActivity: UIActivityIndicatorView!
    
    //MARK: API downdlad
    var ImageArray = [String]()

    // загрузка Data из API
    func getDataFromAPI(_ yourString: String?, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        let name = yourString?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let API = URL(string: "https://api.qwant.com/api/search/images?count=20&offset1&q=\(String(describing: name!.replacingOccurrences(of: " ", with: "")))")
            URLSession.shared.dataTask(with: API!) { (data, response, error) in
                completion(data,response,error)
            }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        
        //view.addTapGestureToHideKeyboard()
        
        //ResurchUserText.addTarget(self, action: #selector()), for: UIControlEvents.editingDidEnd)
        // Uncomment the following line to preserve selection between presentations
        
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goPhoto"
        {
            // Даём понять, что sender это ячейка класса MyCell
            let cell: MyCell  = sender as! MyCell
            // Получает объект image из текущей ячейки
            let image = cell.FindImage.image
            let previewVC = segue.destination as! PreviewVCViewController
            previewVC.currentPhoto = image
        }
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ImageArray.count
    }

    //конфигурируем ячейку
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.layer.cornerRadius = 10
        if let loveCell = cell as? MyCell{
            if ImageArray.count != 0 {
        print("")
        loveCell.imageURL = URL(string: ImageArray[indexPath.row])
            }
        }
        // Configure the cell
        return cell
    }
    
    
    
    
    
    // ↓Анимация нажатия ячейки↓
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? MyCell{
                cell.FindImage.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? MyCell{
            cell.FindImage.transform = .identity
            cell.contentView.backgroundColor = .clear
            }
        }
    }
    //  ↑Анимация нажатия ячейки↑

    
    
    
    
    // -------- ↓Поиск↓
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            
            return headerView
        }
        return UICollectionReusableView()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            print(searchBar.text!)
            surchActivity.startAnimating()
            self.download(stringSerch: searchBar.text!)
            self.collectionView?.reloadData()
            
        }else{
            let alert = UIAlertController(title: "Запрос пустой", message: "Введите поисковой запрос", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("pidor")
            return
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            //reload your data source if necessary
            //при нажатии на крестик
        }
    }
    /*
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "goPhoto", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "goPhoto") as! PreviewVCViewController
        let cell = MyCell()
        vc.currentPhoto = cell.FindImage.image!
        self.present(vc, animated: true, completion: nil)
    }
 */
    // ↑↑--- Поиск↑↑
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        performSegue(withIdentifier: "goPhoto", sender: ImageArray[indexPath.row])
        return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}



extension ImageCollectionViewController{
    func download(stringSerch:String){
        let queue = DispatchQueue.global(qos: .utility)
        let allert = UIAlertController(title: "Не найдено", message: "введите другой запрос", preferredStyle: UIAlertControllerStyle.alert)
        allert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        queue.async {
            self.ImageArray.removeAll()
            self.getDataFromAPI(stringSerch) {data, response, error in
            if let data = data{
                do{
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                        DispatchQueue.main.async {
                            let mainResults = jsonResult["data"] as! NSDictionary
                            let infoResults = mainResults["result"] as! NSDictionary
                            if let resultsArray = infoResults["items"] as? NSArray{
                                self.surchActivity.stopAnimating()// останавливаем главный индикотор активности
                                for i in resultsArray{
                                    let dic = i as! NSDictionary
                                    self.ImageArray.append(dic["media"] as! String)
                                }
                            }
                            if self.ImageArray.count == 0 {
                                self.present(allert, animated: true, completion: nil)
                            }

                            self.collectionView?.reloadData()
                        }
                        
                    }
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
                print("-----------")
            }
        }
        }
    }
}


