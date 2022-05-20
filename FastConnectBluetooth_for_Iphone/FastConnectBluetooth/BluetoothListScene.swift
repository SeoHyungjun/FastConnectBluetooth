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
    @EnvironmentObject var blelist: BLEConnection
    //formatter 속성 추가
    @EnvironmentObject var formatter: DateFormatter
    
    var body: some View {
        NavigationView {
            List(blelist.list2) {
                bluetooth in
                //배열에 저장되어있는 bluetooth가 파라미터로 전달
                //텍스트로 bluetooth 내용 전달
                
                //alignment를 leading으로 설정하면 왼쪽 정령
                VStack(alignment: .leading) {
                    //Text(bluetooth.content)
                    Text(bluetooth.content)
                    //텍스트에 모디파이어를 설정하고 기본 속성 변경
                        //기본 폰트중 body로 설정
                        .font(.body)
                        //메모 내용 한줄만 표시, 길다면 뒷부분 생략
                        .lineLimit(1)
                    
                    Text("\(bluetooth.insertDate, formatter: self.formatter)")
                        .font(.caption)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
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
            .environmentObject(DateFormatter.bluetoothDateFormatter)
        
            .environmentObject(BLEConnection())
    }
}
