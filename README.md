# hxtg - Small wrapper over basics of Telegram HTTPS API in Haxe 

## ATTENTION!
App is not currently working, as saving last message ID is not yet implemeted. Certain changes should be done in code in order to make it work again

### Functionality:
The app currently is capable of sending basic text messages to user in the chat, as well as capable of setting callbacks on long-polling updates via getUpdates.
- The app was specifically implemented for Neko target and might need to adjust specifical features to compile and run under specific architectures.

### Install and Run
- Clone the repository:
```cmd
git clone https://github.com/enderavour/hxtg.git
```
- Build and run:
```cmd
haxe build.hxml && ./tghx
```

# Info
- Would suggest improvements of bot structure such as using asynchronous runtimes (e.g. tink_await) or moving to Webhook approach, becase haxe.Http is synchronous only.
- An overall structure of the bot should be reworked, as not the best practices were used during it's design.
- Contributors are welcome.
