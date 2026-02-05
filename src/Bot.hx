import haxe.Int64Helper;
import haxe.Int64;
import Callback.MessageCallback;
import haxe.Http;
import haxe.Json;

class Bot
{
    public var botToken: String;
    private final _tgHttpEndpoint = 'https://api.telegram.org/bot';
    private var botCallbacks: Map<MessageCallback, Bot -> Dynamic -> Void>;
    private static var lastUpdateId: Int64;
    
    function set_botToken(botToken: String)
    {
        this.botToken = botToken;
        return this.botToken;
    }

    public function new(token: String) 
    {
        this.botToken = token;
        botCallbacks = new Map();
        lastUpdateId = Int64.ofInt(0);
    }

    public function sendTextMessage(chat_id: Int64, message: String) 
    {
        var httpEndpoint = _tgHttpEndpoint + botToken + "/sendMessage";
        var request = new Http(httpEndpoint);
        request.setHeader("Content-Type", "application/json");

        request.onData = function(data) 
        {
            var ms = Message.parseMessage(data);
            Sys.println(ms.result.message_id);
        };
        request.onError = function(data) 
        {
            Sys.println(data);
        };

        var payload = {
            chat_id: chat_id,
            text: message
        };
        var json = Json.stringify(payload, null);

        request.setPostData(json);
        request.request(true);
    }

    /** Polls the last update in the chat, using long polling **/
    public function pollUpdate() 
    {
        var httpEndpoint = _tgHttpEndpoint + botToken + "/getUpdates";
        var request = new Http(httpEndpoint);
        var self = this;

        request.setParameter("limit", "1");
        request.setParameter("timeout", "0");

    lastUpdateId += 1;
    request.setParameter("offset", Int64.toStr(lastUpdateId));

    request.onData = function(mes)
    {
        var upd = Update.parseTgUpdate(mes);
        var mtype = Callback.getMessageType(upd);

        lastUpdateId = Int64.parseString(upd.result[0].update_id);

        switch (mtype)
        {
            case Text:
                var textHandler = botCallbacks.get(mtype);
                if (textHandler != null)
                    textHandler(self, upd);
            default:
        }
    }
        request.request(true);
    }

    public function run() 
    {
        while (true)
        {
            pollUpdate();
            Sys.sleep(0.1);
        } 
    }

    public function registerCallback(type: MessageCallback, func: Bot -> Dynamic -> Void) 
    {
        this.botCallbacks.set(type, func);
    }
}