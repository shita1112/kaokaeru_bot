require "open-uri"
require "twitter"
require "pry-byebug"
require "active_hash"
require_relative "kaokaeru_bot/twitter"
require_relative "kaokaeru_bot/face_changer"
require_relative "kaokaeru_bot/base_command"
require_relative "kaokaeru_bot/faceswap_py"

class KaokaeruBot
  DEEP_ROOT = File.expand_path("../../../../", __FILE__)

  def self.call
    new.call
  end

  def initialize
    @mention = KaokaeruBot::Twitter.new.mention
  end

  def call
    return unless @mention.valid?

    @mention.change_face
    @mention.reply
    @mention.write_finished_mention
  end
end
