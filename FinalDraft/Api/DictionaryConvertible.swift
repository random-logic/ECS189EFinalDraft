protocol DictionaryConvertible {
    func toDictionary() -> [String: Any]
}

// Convert everything to dictionary except for id
extension DictionaryConvertible {
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            if let key = child.label {
                if key != "id" {
                    dictionary[key] = child.value
                }
            }
        }
        
        return dictionary
    }
}
