//
//  BLEConnection.swift
//  FastConnectBluetooth
//
//  Created by hyungjun on 2020/06/04.
//  Copyright © 2020 hyungjun. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class BLEConnection: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate, ObservableObject {
    @Published var list2: [Bluetooth] = []
    //@Published var list2 = [
    //    Bluetooth(content: "...")
    //]
    var scannedBLEDevices: [String] = []
    
    // Properties
    private var centralManager: CBCentralManager! = nil
    private var peripheral: CBPeripheral!

    public static let bleServiceUUID = CBUUID.init(string: "FF00")
    //public static let bleCharacteristicUUID = CBUUID.init(string: "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX")
    public static let bleCharacteristicUUID = CBUUID.init(string: "0000110b-0000-1000-8000-00805F9B34FB")

    // Array to contain names of BLE devices to connect to.
    // Accessable by ContentView for Rendering the SwiftUI Body on change in this array.
    
    
    func startCentralManager() {
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        print("Central Manager State: \(self.centralManager.state)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.centralManagerDidUpdateState(self.centralManager)
        }
    }

    // Handles BT Turning On/Off
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
           case .unsupported:
            print("BLE is Unsupported")
            break
           case .unauthorized:
            print("BLE is Unauthorized")
            break
           case .unknown:
            print("BLE is Unknown")
            break
           case .resetting:
            print("BLE is Resetting")
            break
           case .poweredOff:
            print("BLE is Powered Off")
            break
           case .poweredOn:
            print("Central scanning for", BLEConnection.bleServiceUUID);
            //self.centralManager.scanForPeripherals(withServices: [BLEConnection.bleServiceUUID],options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            //self.centralManager.scanForPeripherals(withServices: nil, options: nil)
            self.centralManager.scanForPeripherals(withServices: nil, options: nil)
            //self.centralManager.scanForPeripherals(withServices: [BLEConnection.bleCharacteristicUUID],options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            break
        @unknown default:
            print("fatal error")
        }

       if(central.state != CBManagerState.poweredOn)
       {
           // In a real app, you'd deal with all the states correctly
           return;
       }
    }


    // Handles the result of the scan
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //print("Peripheral Name: \(String(describing: peripheral.name))  RSSI: \(String(RSSI.doubleValue))")
        // We've found it so stop scan
        //self.centralManager.stopScan()
        // Copy the peripheral instance
        self.peripheral = peripheral
        //self.scannedBLEDevices.append(peripheral.name!)
        if peripheral.name != nil {
            print(peripheral.name as Any)
            
            if !(scannedBLEDevices.contains(peripheral.name!)) {
                scannedBLEDevices.insert(peripheral.name!, at: 0)
                
            /*if !(list2.contains(Bluetooth(content: peripheral.name!))) {
                if list2.contains(Bluetooth(content: "...")) {
                    list2.removeAll()
                }
                 */
                list2.insert(Bluetooth(content: peripheral.name!), at: 0)
            }
        }
        self.peripheral.delegate = self
        // Connect!
        //self.centralManager.connect(self.peripheral, options: nil)
    }


    // The handler if we do connect successfully
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == self.peripheral {
            print("Connected to your BLE Board")
            peripheral.discoverServices([BLEConnection.bleServiceUUID])
        }
    }


    // Handles discovery event
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                if service.uuid == BLEConnection.bleServiceUUID {
                    print("BLE Service found")
                    //Now kick off discovery of characteristics
                    peripheral.discoverCharacteristics([BLEConnection.bleCharacteristicUUID], for: service)
                    return
                }
            }
        }
    }

    // Handling discovery of characteristics
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == BLEConnection.bleServiceUUID {
                    print("BLE service characteristic found")
                } else {
                    print("Characteristic not found.")
                }
            }
        }
    }
}
