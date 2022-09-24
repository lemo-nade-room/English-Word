import Vapor

extension Request {
    var translator: Translatable {
        guard let key = Environment.get("DeepL_API_KEY") else {
            fatalError("DeepLキーがありません")
        }
        return DeepLTranslator(client: client, key: key)
    }
}
