class KaokaeruBot
  class Mention
    def initialize(mention)
      @mention = mention
    end

    def change_face
      FaceChanger.new(self).change
    end

    def reply
      @client.update_with_media(
        "@#{@mention.user.screen_name} #{text}",
        changed_face,
        in_reply_to_status_id: @mention.id
      )
    end

    def valid?
      @mention || media
    end

    def write_finished_mention
      File.write(finished_path, "")
    end

    def face
      KaokaeruBot::Face.all.find { |face| face.word.match?(@mention.text) }
    end

    private

    def finished_path
      KaokaeruBot::MENTION_IDS_DIR.join(id)
    end

    def text
      "顔を変えましたー"
    end

    def kao_path
      Dir[KaokaeruBot::KAODIR.join(id, "df")][0]
    end

    def changed_face
      File.read(kao_path)
    end

    def id
      @mention.id
    end

    def media
      @mention.media[0]
    end

    def original_face
      open(media.media_uri).read if media
    end
  end
end
