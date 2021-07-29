//
//  SimulasiData.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 28/07/21.
//

import UIKit

struct SimulasiData {
    static var simulasi: [Simulasi] {
        get {
            return [
                Simulasi(waktu: 1, tanggal: 1, duration: 1),
                Simulasi(waktu: 2, tanggal: 2, duration: 2),
                Simulasi(waktu: 3, tanggal: 3, duration: 3),
                Simulasi(waktu: 4, tanggal: 4, duration: 4)
            ]
        }
    }
}
