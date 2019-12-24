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
      KaokaeruBot::Mention.new(tweet_mention, @client)
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
      Dir["#{mention_ids_dir}/*"].map { |name| name.sub(mention_ids_dir.to_s + "/", "").to_i }
    end

    def mention_ids_dir
      KaokaeruBot::DEEP_ROOT.join("mention_ids")
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
