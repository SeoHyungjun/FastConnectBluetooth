//
//  ContentView.swift
//  FastConnectBluetooth
//
//  Created by hyungjun on 2020/05/31.
//  Copyright © 2020 hyungjun. All rights reserved.
//

import SwiftUI

struct BluetoothListScene: View {
    //custom 공유 데이터로 등록된 bluetoothstore 인스턴스
    //뷰가 생성되는 시점에 공유 데이터 목록을 확인, 스토어 속성과 동일한 형식을 가진 객체가 등록되어있다면
    //store에 자동으로 저장
    @EnvironmentObject var store: BluetoothStore
    
    var body: some View {
        NavigationView {
            List(store.list) {
                bluetooth in
                //배열에 저장되어있는 bluetooth가 파라미터로 전달
                //텍스트로 bluetooth 내용 전달
                Text(bluetooth.content)
            }
            //modifier(swiftUI에서 특별한 메소드)를 사용해서
            //속성 또는 뷰를 변경
            .navigationBarTitle("My Bluetooth Device")
        }
    }
}

struct BluetoothListScene_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothListScene()
        //프리뷰에서 사용할 bluetooth store를 공유 데이터로 등록
            .environmentObject(BluetoothStore())
    }
}
