//
//  BluetoothStore.swift
//  FastConnectBluetooth
//
//  Created by hyungjun on 2020/05/31.
//  Copyright © 2020 hyungjun. All rights reserved.
//

import Foundation

class BluetoothStore: ObservableObject {
    //배열을 published로 선언하면, 배열 업데이트 시 마다 바인딩 되어있는 뷰도 업데이트
    @Published var list: [Bluetooth]
    
    //생성자를 만들고 더미 데이터 추가
    init() {
        list = [
            Bluetooth(content: "HJ Airpod 1"),
            Bluetooth(content: "HJ Airpod 2"),
            Bluetooth(content: "HJ Airpod 3")
        ]
    }
    
    //기본적인 crud 코드 구현
    //입력한 Bluetooth 장치를 파라미터로 받은 뒤 리스트 배열에 저장
    func insert(bluetooth: String) {
        list.insert(Bluetooth(content: bluetooth), at: 0)
    }
    
    //update 메소드 구현
    func update(bluetooth: Bluetooth?, content: String) {
        //bluetooth 장치를 받은 뒤 body 에서 content 속성에 저장
        guard let bluetooth = bluetooth else { return }
        bluetooth.content = content
    }
    
    //delete 메소드 - bluetooth 인스턴스를 받는 버전
    func delete(bluetooth: Bluetooth) {
        //bluetooth 인스턴스가 전달되면 바로 삭제
        self.list.removeAll() { $0 == bluetooth }
    }
    
    //delete 메소드 - 인덱스 셋을 받는 버전
    func delete(set: IndexSet) {
        //index set이 전달되면 포문으로 반복하면서 배열에서 삭제
        for index in set {
            self.list.remove(at: index)
        }
    }
}
