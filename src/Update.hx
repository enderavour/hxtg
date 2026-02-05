import haxe.Json;
import haxe.Int64;

typedef TgUpdate = {
    ok: Bool,
    result: Array<UResult>
} 

typedef UResult = {
    update_id: String,
    message: UMessage
}

typedef UMessage = {
    message_id: String,
    from: UFrom,
    chat: UChat,
    date: Int64,
    text: String
} 

typedef UFrom = {
    id: String,
    is_bot: Bool,
    first_name: String,
    username: String,
    language_code: String
} 

typedef UChat = {
    id: String,
    first_name: String,
    username: String,
    type: String
} 

class Update
{
    public static function parseTgUpdate(payload: String): TgUpdate
    {
        var upd = Json.parse(payload);
        return upd;
    }
}

