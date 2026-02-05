import Update.TgUpdate;
import haxe.Int64;

class Main
{
    static function main() 
    {   
        var bot = new Bot("8510149429:AAFfnu69lMSBHAkz5a7atV1pLan9coLrsnw");
        bot.registerCallback(Text, text_handler);
        // Bot loop
        bot.run();
    }

    public static function text_handler(bot: Bot, msg: Dynamic): Void 
    {
        var upd: TgUpdate = cast msg;
        bot.sendTextMessage(Int64.parseString(upd.result[0].message.chat.id), upd.result[0].message.text);
    }
}