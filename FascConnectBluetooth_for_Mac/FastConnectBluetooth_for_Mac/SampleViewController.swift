//
//  SampleViewController.swift
//  FastConnectBluetooth_for_Mac
//
//  Created by hyungjun on 2022/05/20.
//

import Cocoa
import CoreBluetooth

class SampleViewController: NSViewController {
    private var centralManager: CBCentralManager!
    
    @IBOutlet var resultTextView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTextView.layer?.cornerRadius = 30
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    @IBAction func clickedRunButton(_ sender: Any) {
        resultTextView.string = "hyungjun seo test"
    }
    
}

extension SampleViewController: CBCentralManagerDelegate {
    
    static func freshController() -> SampleViewController {
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        
        let identifier = NSStoryboard.SceneIdentifier("SampleViewController")
        
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SampleViewController else {
            fatalError("Why cant i find SampleViewController? - Check Main.stroyboard")
        }
        return viewcontroller
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unknown:
                print("central.state is unknown")
            case .resetting:
                print("central.state is resetting")
            case .unsupported:
                print("central.state is unsupported")
            case .unauthorized:
                print("central.state is unauthorized")
            case .poweredOff:
                print("central.state is poweredOff")
            case .poweredOn:
                print("central.state is poweredOn")
            @unknown default:
                print("central.state default case")
        }
    }
}
