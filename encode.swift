
    func ezEncode(_ password: String) -> String {
        let ezEncodeChars = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/")
        let array = Array(password)
        let length = array.count
        var i = 0
        var result = ""
        
        while i < length {
            if let ascii = array[i].asciiValue {
                let c1 = ascii & 0xff
                let intC1 = Int(c1)
                i = i + 1
                if i == length {
                    result.append(ezEncodeChars[intC1 >> 2])
                    result.append(ezEncodeChars[(intC1 & 0x3) << 4])
                    result.append("==")
                    break
                }
                if let c2 = array[i].asciiValue {
                    let intC2 = Int(c2)
                    i = i + 1
                    if i == length {
                        result.append(ezEncodeChars[intC1 >> 2])
                        result.append(ezEncodeChars[((intC1 & 0x3) << 4) | ((intC2 & 0xF0) >> 4)])
                        result.append(ezEncodeChars[(intC2 & 0xF) << 2])
                        result.append("=")
                        break
                    }
                    
                    if let c3 = array[i].asciiValue {
                        let intC3 = Int(c3)
                        i = i + 1
                        result.append(ezEncodeChars[intC1 >> 2])
                        result.append(ezEncodeChars[((intC1 & 0x3) << 4) | ((intC2 & 0xF0) >> 4)])
                        result.append(ezEncodeChars[((intC2 & 0xF) << 2) | ((intC3 & 0xC0) >> 6)])
                        result.append(ezEncodeChars[intC3 & 0x3F])
                        
                    }
                }
            }
        }
        
        return result // Please also do urlencode before use!
    }
