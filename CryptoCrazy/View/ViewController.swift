//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by Furkan on 16.12.2022.
//

import UIKit

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    private var cryptoListViewModel : CryptoListViewModel!
    
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.colorArray = [
            UIColor(red: 75/250, green: 150/255, blue: 204/255, alpha: 1.0),
            UIColor(red: 45/250, green: 120/255, blue: 14/255, alpha: 1.0),
            UIColor(red: 56/250, green: 30/255, blue: 54/255, alpha: 1.0),
            UIColor(red: 185/250, green: 90/255, blue: 64/255, alpha: 1.0),
            UIColor(red: 200/250, green: 10/255, blue: 95/255, alpha: 1.0),
            UIColor(red: 15/250, green: 200/255, blue: 105/255, alpha: 1.0),
            UIColor(red: 120/250, green: 65/255, blue: 185/255, alpha: 1.0),
            UIColor(red: 100/250, green: 185/255, blue: 170/255, alpha: 1.0)
        ]
        
      getData()
        
     /*   let myString = "dsad"
        myString.printMyName()*/
    }
    
    func getData(){
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { cryptos in
            if let cryptos = cryptos{
                
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        
        cell.priceText.text = cryptoViewModel.price
        cell.currencyText.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 8]
        
        return cell
    }


}

