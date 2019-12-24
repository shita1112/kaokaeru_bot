require "open-uri"
require "twitter"
require "pry-byebug"
require "active_hash"
require "rake"
require 'timeout'
require_relative "kaokaeru_bot/twitter"
require_relative "kaokaeru_bot/face_changer"
require_relative "kaokaeru_bot/base_command"
require_relative "kaokaeru_bot/faceswap_py"
require_relative "kaokaeru_bot/mention"
require_relative "kaokaeru_bot/face"

class KaokaeruBot
  DEEP_ROOT = Pathname.new File.expand_path("../../../", __FILE__)

  def self.call
    new.call
  end

  def initialize
    @mention = KaokaeruBot::Twitter.new.mention
  end

  def call
    return unless @mention.mention

    begin
      @mention.change_face
      @mention.reply
    rescue
      @mention.reply_error
    end

    @mention.write_finished_mention
  end
end
