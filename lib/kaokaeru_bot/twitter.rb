class KaokaeruBot
  class Twitter
    MENTION_IDS_DIR = KaokaeruBot::DEEP_ROOT.join("kaokaeru_bot", "mentions")

    def initialize
      @client = ::Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
      end
    end

    def mention
      KaokaeruBot::Mentio.new(tweet_mention)
    end

    private
    def tweet_mention
      mentions_timeline.find { |mention| mention.id === mention_id }
    end

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
