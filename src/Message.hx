import haxe.Json;
import haxe.Int64;

typedef TgMessage = {
    ok: Bool,
    result: TResult
};

typedef TResult = {
    message_id: Int,
    from: TFrom,
    chat: TChat,
    date: Int64,
    text: String
}

typedef TFrom = {
    id: Int64,
    is_bot: Bool,
    first_name: String,
    username: String
}

typedef TChat = {
    id: Int64,
    first_name: String,
    username: String,
    type: String
}

class Message 
{
    public static function parseMessage(response: String): TgMessage
    {
        var ms: TgMessage = Json.parse(response);
        return ms;
    }
}