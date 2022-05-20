//
//  DateFormatter+Bluetooth.swift
//  FastConnectBluetooth
//
//  Created by hyungjun on 2020/06/01.
//  Copyright © 2020 hyungjun. All rights reserved.
//

import Foundation

//extension을 추가한 다음 Date에 time property 추가
extension DateFormatter {
    static let bluetoothDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "Kp_kr")
        return f
    } ()
}

//DateFormatter 클래스의 옵져버블 오브젝트 프로토콜 구현 추가
extension DateFormatter:ObservableObject{
    
}
