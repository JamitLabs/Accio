import Foundation

final class Config: Codable {
    var defaultSharedCachePath: String?

    init(defaultSharedCachePath: String?) {
        self.defaultSharedCachePath = defaultSharedCachePath
    }

    static func load() throws -> Config {
        guard FileManager.default.fileExists(atPath: Constants.configFilePath) else {
            let config = Config(defaultSharedCachePath: nil)
            try config.save()
            return config
        }

        let data = try String(contentsOfFile: Constants.configFilePath, encoding: .utf8).data(using: .utf8)!
        let config = try JSONDecoder().decode(Config.self, from: data)
        return config
    }

    func save() throws {
        if FileManager.default.fileExists(atPath: Constants.configFilePath) {
            try FileManager.default.removeItem(atPath: Constants.configFilePath)
        }

        let data = try JSONEncoder().encode(self)
        try FileManager.default.createFile(atPath: Constants.configFilePath, withIntermediateDirectories: true, contents: data, attributes: nil)
    }
}
