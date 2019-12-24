class KaokaeruBot
  class Face < ActiveHash::Base
    self.data = [
      { type: "japanese_woman", trainer: "unbalanced", word: "美人" },
      { type: "white_woman", trainer: "villain", word: "爽やか" },
      { type: "white_young_man", trainer: "unbalanced", word: "イケメン" },
      { type: "japanese_man", trainer: "villain", word: "アイドル" },
      { type: "white_man", trainer: "villain", word: "髭" },
      { type: "donald_trump", trainer: "villain", word: "大統領" },
      { type: "emma_watson", trainer: "villain", word: "エマ" },
    ]
  end
end
