class KaokaeruBot
  class Twitter
    def initialize
      @client = ::Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
      end
    end

    def mention
      mentions_timeline.find { |mention| mention.id === mention_id }
    end

    def reply(text, media, tweet)
      @client.update_with_media(
        "@#{tweet.user.screen_name} #{text}",
        media,
        in_reply_to_status_id: tweet.id
      )
    end

    private

    def mentions_timeline
      @mentions_timeline ||= @client.mentions_timeline
    end

    def recent_ids
      mentions_timeline.map(&:id)
    end

    def finished_ids
      Dir["#{MENTION_IDS_DIR}/*"].map { |name| name.delete(MENTION_IDS_DIR).to_i }
    end

    def mention_ids
      recent_ids - finished_ids
    end

    def mention_id
      mention_ids[-1]
      # mention_ids[0] # debug
    end
  end
end
