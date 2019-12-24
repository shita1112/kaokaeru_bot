class KaokaeruBot
  class Mention
    attr_accessor :word

    def initialize(mention, client)
      @mention = mention
      @client = client
    end

    def change_face
      @result = FaceChanger.new(self).change_face
    end

    def reply
      @client.update_with_media(
        "@#{@mention.user.screen_name} #{message}",
        changed_face,
        in_reply_to_status_id: @mention.id
      )
    end

    def reply_error
      @client.update(
        "@#{@mention.user.screen_name} 顔が検出できませんでした。",
        in_reply_to_status_id: @mention.id
      )
    end

    def write_finished_mention
      File.write(finished_path.to_s, "")
    end

    def face
      @face ||= KaokaeruBot::Face.all.to_a.find { |face| @mention.text.include(face.word) } || KaokaeruBot::Face.all.sample
    end

    def message
      [
        "とても#{@face.word}です(ΦωΦ)",
        "これは#{@face.word}なのだろうか？(ΦωΦ)",
        "#{@face.word}にしたよー(ΦωΦ)",
        "#{@face.word}ならこんな感じ？(ΦωΦ)",
        "#{@face.word}に変えてみた！(ΦωΦ)",
        "#{@face.word}にしてみたけどどうだろう？(ΦωΦ)"
      ].sample
    end

    def id
      @mention.id.to_s
    end

    def original_face
      open(media.media_uri).read if media
    end

    def media
      @media ||= @mention.media[0]
    end

    private

    def finished_path
      KaokaeruBot::DEEP_ROOT.join("mention_ids", id)
    end

    def kao_path
      Dir[KaokaeruBot::DEEP_ROOT.join("kaodir", id, "df")][0]
    end

    def changed_face
      File.read(kao_path)
    end
  end
end
