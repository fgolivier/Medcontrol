//
//  ViewController.swift
//  MedControl
//
//  Created by Admin on 22/09/15.
//  Copyright (c) 2015 Puc-CCE. All rights reserved.
//

import UIKit

class MedControlViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var medCtlTableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.medCtlTableViewOutlet.delegate = self
        self.medCtlTableViewOutlet.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let emUsoMedCtl: MedCtlTableViewCell = tableView.dequeueReusableCellWithIdentifier("controleMedicamentoCell") as! MedCtlTableViewCell
        
        return emUsoMedCtl
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


}

