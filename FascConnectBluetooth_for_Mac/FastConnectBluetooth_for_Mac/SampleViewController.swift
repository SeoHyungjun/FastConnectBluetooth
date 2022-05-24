//
//  SampleViewController.swift
//  FastConnectBluetooth_for_Mac
//
//  Created by hyungjun on 2022/05/20.
//

import Cocoa

class SampleViewController: NSViewController {
    
    @IBOutlet var resultTextView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func clickedRunButton(_ sender: Any) {
        resultTextView.string = "hyungjun seo test"
    }
    
}

extension SampleViewController {
    
    static func freshController() -> SampleViewController {
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        
        let identifier = NSStoryboard.SceneIdentifier("SampleViewController")
        
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SampleViewController else {
            fatalError("Why cant i find SampleViewController? - Check Main.stroyboard")
        }
        return viewcontroller
    }
}
