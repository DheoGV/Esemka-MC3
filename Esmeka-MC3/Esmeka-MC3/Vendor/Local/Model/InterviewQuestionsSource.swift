//
//  InterviewQuestionsSource.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 05/08/21.
//

import Foundation


enum InterviewQsType:CaseIterable{
    case Profil_Kandidat
    case Team_Work
    case Resiliensi
    case Eager_to_Learn
}


struct InterviewQuestionsSource{
    private let questions: [InterviewQsType:[String]] = [
        .Profil_Kandidat : ["Ceritakan tentang diri Anda beserta kelebihan dan kekurangan."],
        .Team_Work : ["Ceritakan tentang pengalaman saat bekerja dalam tim dan peran Anda dalam tim?",
                      "Jika Anda bekerja dalam tim dan rekan kerja Anda tidak bekerja secara maksimal sehingga menghambat tujuan tim, apa yang akan Anda lakukan?",
                      "Jika Anda memiliki rekan kerja tim yang secara personal karakternya tidak cocok dengan karakter Anda, bagaimana Anda akan bersikap?",
                      "Bagaimana pendapat Anda mengenai tim yang ideal?",
                      "Jelaskan pengalaman Anda dalam sebuah tim dan harus bertindak cepat serta dampaknya bagi tim Anda?"],
        .Resiliensi : ["Apa pendapat Anda jika mendapat tugas di luar job description dan apa yang akan Anda lakukan? ",
                       "Ceritakan salah satu kegagalan Anda dan bagaimana Anda mengatasinya sehingga mampu bangkit kembalI?",
                       "Ceritakan pengalaman Anda ketika berada dalam situasi terpuruk atau titik terendah dalam hidup dan bagiamna Anda mampu bangkit kembali?",
                       "Ceritakan pengalaman Anda saat menghadapi sebuah tantangan terbesar dan bagaimana Anda menyelesaikan tantangan tersebut?"],
        .Eager_to_Learn : ["Apakah motivasi Anda dalam bekerja dan apa ekspektasi Anda terhadap perusahaan?",
                           "Ceritakan pengalaman kesuksesan yang pernah Anda raih dan bagaiman proses Anda meraih kesuksesan tersebut?"],
    ]
    private let pattern = [1,2,1,1]
    
    private func aspectNumber(index:Int)->InterviewQsType{
        switch index {
        case 0:
            return .Profil_Kandidat
        case 1:
            return .Team_Work
        case 2:
            return .Resiliensi
        case 3:
            return .Eager_to_Learn
        default:
            return .Profil_Kandidat
        }
    }
    
    func getTotalQs()->Int{
        var total = 0
        for i in 0..<pattern.count{
            total += pattern[i]
        }
        return total
    }
    
    func getQuestions()->[String]{
        var qs:[String] = []
        for i in 0..<InterviewQsType.allCases.count {
            var variation = questions[aspectNumber(index: i)]! as [String]
            for _ in 0..<pattern[i]{
                let randomIndex = Int.random(in: 0..<variation.count)
                qs.append(variation[randomIndex])
                variation.remove(at: randomIndex)
            }
        }
        return qs
    }
    
}
