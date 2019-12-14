require "open-uri"
require "twitter"
require "pry-byebug"
require_relative "kaokaeru_bot/twitter"
require_relative "kaokaeru_bot/face_changer"

class KaokaeruBot
  MENTION_IDS_DIR = File.expand_path("../../mention_ids", __FILE__)

  def self.call
    new.call
  end

  def initialize
    @twitter = KaokaeruBot::Twitter.new
  end

  def call
    return unless mention
    return unless media

    change_face
    reply
    write_finished_mention
  end

  private

  def mention
    @mention ||= @twitter.mention
  end

  def media
    mention.media[0]
  end

  def original_face
    open(media.media_uri).read if media
  end

  def change_face
    # FaceChanger.new(face_image).change
  end

  def changed_face
    File.open("../../Downloads/chibi-min.JPG")
  end

  def reply
    @twitter.reply("顔を変えました", changed_face, mention)
  end

  def write_finished_mention
    File.write("#{MENTION_IDS_DIR}/#{mention.id}", "")
  end
end
