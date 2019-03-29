import xcodeproj

extension PBXProj {
    func deleteAllTemporaryFileReferences() {
        fileReferences.filter { $0.uuid.hasPrefix("TEMP_") }.forEach { delete(object: $0) }
    }
}
