import Foundation

struct Brand: Identifiable {
    let id = UUID()
    let name: String
    let category: String
}

extension Brand {
    static let brands = [
        Brand(name: "BADWAY", category: "BADWAY"),
        Brand(name: "DAIRIKU", category: "DAIRIKU"),
        Brand(name: "el conductorH", category: "el conductorH"),
        Brand(name: "elephant TRIBAL fabrics", category: "elephant TRIBAL fabrics"),
        Brand(name: "END CUSTOM JEWELLERS", category: "END CUSTOM JEWELLERS"),
        Brand(name: "FACCIES", category: "FACCIES"),
        Brand(name: "FLASH POINT", category: "FLASH POINT"),
        Brand(name: "foot the coacher", category: "foot the coacher"),
        Brand(name: "GHOST", category: "GHOST"),
        Brand(name: "JieDa", category: "JieDa"),
        Brand(name: "JUN/NAKAYAMA", category: "JUN/NAKAYAMA"),
        Brand(name: "Kota Gushiken", category: "Kota Gushiken"),
        Brand(name: "meanswhile", category: "meanswhile"),
        Brand(name: "OUTLW USA", category: "OUTLW USA"),
        Brand(name: "PPACO", category: "PPACO"),
        Brand(name: "RACER WORLDWIDE", category: "RACER WORLDWIDE"),
        Brand(name: "remagine", category: "remagine"),
        Brand(name: "saby", category: "saby"),
        Brand(name: "SEVEN BY SEVEN", category: "SEVEN BY SEVEN"),
        Brand(name: "SHOOP", category: "SHOOP"),
        Brand(name: "Stolen Girlfriends Club", category: "Stolen Girlfriends Club"),
        Brand(name: "TAAKK", category: "TAAKK"),
        Brand(name: "Tareet", category: "Tareet"),
        Brand(name: "TENDER PERSON", category: "TENDER PERSON"),
        Brand(name: "THE SUGAR PUNCH", category: "THE SUGAR PUNCH"),
        Brand(name: "The Letters", category: "The Letters"),
        Brand(name: "UNDECORATED", category: "UNDECORATED"),
        Brand(name: "Y.A.R.N.", category: "Y.A.R.N."),
        Brand(name: "71 MICHAEL", category: "71 MICHAEL")
    ]
} 