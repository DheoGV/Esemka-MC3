//
//  BriefInstructionModel.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 29/07/21.
//

import Foundation
import Foundation

struct BriefModel {
    var title : String
    var content :String
    
    static var BriefData : [BriefModel] =  [BriefModel(title: "Tata Krama dan Bahasa Tubuh", content: "Pastikan kamera dapat berfungsi serta tidak ada distraksi suara. Kondisikan diri Anda seolah-olah bertemu secara langsung dengan pewawancara. Berpakaianlah dengan rapi dan menjaga postur tubuh dengan duduk tegak menghadap kamera."),
                                            BriefModel(title: "Ekspresi Wajah dan Kontak Mata ", content: "Ekspresi wajah dapat menunjukkan emosi Anda, sehingga tersenyumlah saat proses wawancara berlangsung. Pastikan posisi mata sejajar dengan lensa kamera karena kontak mata menunjukkan adanya antusiasme Anda saat proses wawancara."),
                                            BriefModel(title: "Paralingustik", content: "Cara berkomunikasi saat melakukan wawancara sebaiknya meminimalisir penggunaan pemisahan antar kalimat, misalnya: uhmm, ee, uh, ah. Di samping itu, perhatikan pula volume suara serta kecepatan berbicara saat proses wawancara.")]
    
}
