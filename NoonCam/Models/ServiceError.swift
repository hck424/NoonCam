enum ServiceError: String, Error {
    case some = "Some error occurs"
    case encodingJpgDataError = "Encoding JpgData Error"
    case resultDataEmpty = "Result Data Empty"
    case server = "Server Error Result Code Not 01"
    case dataEmpty = "Data Empty nil"
}
