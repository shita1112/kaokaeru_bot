class KaokaeruBot
  class Face < ActiveHash::Base
    self.data = [
      { type: "white_woman", trainer: "villain", word: /さわやか|爽やか|美少年/ },
      { type: "white_young_man", trainer: "unbalanced", word: /イケメン/ },
      { type: "japanese_woman", trainer: "unbalanced", word: /美女|美人/ },
      { type: "japanese_man", trainer: "villain", word: /美少女|アイドル/ },
      { type: "white_man", trainer: "villain", word: /ひげ|ヒゲ|髭|おっさん|ダンディー/ },
      { type: "donald_trump", trainer: "villain", word: /トランプ|大統領/ },
      { type: "emma_watson", trainer: "villain", word: /エマ|ワトソン/ },
    ]
  end
end
