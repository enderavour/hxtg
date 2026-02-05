import haxe.macro.Expr;
import Update.TgUpdate;

enum MessageCallback
{
    Text;
    Unknown;
}

class Callback 
{
    public static function getMessageType(update: TgUpdate): MessageCallback
    {
        if (update.result[0].message != null)
        {
            return Text;
        }
        return Unknown;
    }

}

