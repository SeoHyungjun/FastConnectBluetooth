//
//  Bluetooth.swift
//  FastConnectBluetooth
//
//  Created by hyungjun on 2020/05/31.
//  Copyright © 2020 hyungjun. All rights reserved.
//

import SwiftUI

//Identifiable 데이터 목록을 테이블뷰나 컬렉션뷰에 쉽게 바인딩 가능
//ObservableObject 반응형 Ui 구현에 필요
class Bluetooth: Identifiable, ObservableObject {
    //id는 Identifiable이 요구하는 속성, 유일하게 구분할 때 사용
    let id: UUID
    
    //메모 내용 저장
    //Published 특성을 추가하면 새로운 값 추가시 바인딩 된 UI가 자동으로 업데이트
    @Published var content: String
    
    //날짜 저장
    let insertDate: Date
    
    //앞에서 생성한 3가지 속성을 초기화
    init(id: UUID = UUID(), content: String, insertDate: Date = Date()) {
        self.id = id
        self.content = content
        self.insertDate = insertDate
    }
}

//새로운 extension 추가, Equatable 프로토콜 구현
extension Bluetooth: Equatable {
    //id 속성 비교
    static func == (lhs: Bluetooth, rhs: Bluetooth) -> Bool {
        return lhs.id == rhs.id
    }
}
