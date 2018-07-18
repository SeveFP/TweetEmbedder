# TweetEmbedder

Riddim plugin to embed screen-captured tweets into XMPP clients.

## How it looks:
![TweetEmbedder in action](https://i.imgur.com/vdKSLQd.jpg)

## Requirements and instructions for current setup (GNU/Linux only):
* The bot has to be executed in the HTTP server offering the HTTP Upload downloads.
* Download Riddim https://www.thiessen.im/2010/10/riddim-a-neat-little-xmpp-bot-written-in-lua/
* Download PhantomJS http://phantomjs.org/download.html
* Download twitter_rasterize.js https://github.com/SeveFP/phantomjs/blob/master/examples/twitter_rasterize.js
* Create a directory in `riddim/plugins` called `tweet_embedder_utils` and place `phantomjs`'s directory and `twitter_rasterize.js`
* Place this plugin (`tweet_embedder.lua`) in `riddim/plugins/`
* Configure Riddim to join the MUCs you are interested in.


## Rationale
I happen to be in a room where the participants share links to tweets in a frequent way.
Usually those tweets are additions to comments by the participants or short messages that do not require
reading the full thread of that tweet.
Specially on mobile phones, the experience is annoying, opening the link and waiting for the page to load just to read a
quick joke, or small information that could be copied and pasted directly.
If ignoring the downside of the XMPP client downloading an image, this plugin helps beforehand to know if it is required to
actually visit the link or if that tweet provides enough context for the conversation.

Most probably, other solutions are better, like doing it as an XMPP server component,
this way the user could request for the feature or not. As it is right now, the image is sent to all the participants,
which can be not desired.


## Comments
This is just a bit messy and temporary solution I use and share it in case there is someone with the same needs and can duplicate the setup.
There are things to improve like avoiding to place the bot along with the HTTP Upload files. When the plugin was written, verse (Riddim's XMPP library) didn't have support for HTPP Upload, so the bot had no built-in way to upload files.
There is also the issue that apparently, http://phantomjs.org 's activity has stopped and probably other solutions like https://slimerjs.org/ could be used. 

Right now I leave it as is because I don't have the need to improve it (yet).
