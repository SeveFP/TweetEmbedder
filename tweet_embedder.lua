local st = require "util.stanza";
local domain_name = "" -- The HTPP upload domain. Example: https://upload.domain.tld/tweets/
local screenshot_directory = "" -- Where your HTTP upload files are placed. Example: /var/www/upload/tweets/
local phantomjs_location = "riddim/plugins/tweet_embedder_utils/phantomjs/bin/phantomjs"
local rasterizejs_location = "riddim/plugins/tweet_embedder_utils/twitter_rasterize.js"
local screenshot_format = ".jpeg"
local compression_command = "convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85%" -- fix quality and other parameters to your needs.
local counter = 0


function riddim.plugins.twitter(bot)
	local function create_image(incoming_message)
		local body = incoming_message.body;
		if not body then return; end
		if incoming_message.delay then return; end -- Don't process old incoming_messages from groupchat
        tweet_url = body:match("http?s://w*twitter%S+")
        if not tweet_url then return; end
        if not incoming_message.room then return; end
        local reply_stanza = st.reply(incoming_message.stanza)
        screenshot_name = counter .. screenshot_format
        counter = counter + 1
        os_command = phantomjs_location .. " " .. rasterizejs_location .. " " .. tweet_url .. " " .. screenshot_directory .. screenshot_name .. " \"twitter\""
        os.execute(os_command) -- Make the screenshot
--         os.execute(compression_command .. " "  .. screenshot_directory .. screenshot_name .. " " .. screenshot_directory .. screenshot_name) -- Tweak image's quality
        reply_stanza
            :tag("body"):text(domain_name .. screenshot_name):up()
            :tag("x", {["xmlns"] = "jabber:x:oob"})
                :tag("url"):text(domain_name .. screenshot_name)
        incoming_message.room:send(reply_stanza)
	end

	-- Hook messages from rooms the bot joins
	bot:hook("groupchat/joining", function (room)
		room:hook("message", create_image);
	end);
end
