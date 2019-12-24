class KaokaeruBot
  class Mention
    attr_accessor :word, :mention

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
      # @face ||= KaokaeruBot::Face.all.to_a.find { |face| @mention.text.include?(face.word) } || KaokaeruBot::Face.all.to_a.sample
      @face ||= KaokaeruBot::Face.all.to_a.find { |face| @mention.text.include?(face.word) } || KaokaeruBot::Face.first
    end

    def message
      "#{@face.word}にしました！(ΦωΦ)"
      # [
      #   "とても#{@face.word}です(ΦωΦ)",
      #   "これは#{@face.word}なのだろうか？(ΦωΦ)",
      #   "#{@face.word}にしたよー(ΦωΦ)",
      #   "#{@face.word}ならこんな感じかな？(ΦωΦ)",
      #   "#{@face.word}に変えてみた！(ΦωΦ)",
      #   "#{@face.word}にしてみたけどどうだろう？(ΦωΦ)",
      #   "#{@face.word}にしてみました！(ΦωΦ)"
      # ].sample
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
      KaokaeruBot::DEEP_ROOT.join("kaodir", id, "df", "original_face.png")
    end

    def changed_face
      File.open(kao_path)
    end
  end
end
