import Foundation
#if os(macOS)
    import PostboxMac
#else
    import Postbox
#endif

public struct ArhivedStickerPacksInfoId {
    public let rawValue: MemoryBuffer
    public let id: Int32
    
    init(_ rawValue: MemoryBuffer) {
        self.rawValue = rawValue
        assert(rawValue.length == 4)
        var idValue: Int32 = 0
        memcpy(&idValue, rawValue.memory, 4)
        self.id = idValue
    }
    
    init(_ id: Int32) {
        self.id = id
        var idValue: Int32 = id
        self.rawValue = MemoryBuffer(memory: malloc(4)!, capacity: 4, length: 4, freeWhenDone: true)
        memcpy(self.rawValue.memory, &idValue, 4)
    }
}

public final class ArchivedStickerPacksInfo: OrderedItemListEntryContents {
    public let count: Int32
    
    init(count: Int32) {
        self.count = count
    }
    
    public init(decoder: Decoder) {
        self.count = (decoder.decodeInt32ForKey("c") as Int32)
    }
    
    public func encode(_ encoder: Encoder) {
        encoder.encodeInt32(self.count, forKey: "c")
    }
}