class KaokaeruBot
  class Face < ActiveHash::Base
    self.data = [
      { type: "white_woman", trainer: "villain", word: "美人" },
      { type: "japanese_woman", trainer: "unbalanced", word: "アイドル" },
      { type: "white_young_man", trainer: "unbalanced", word: "イケメン" },
      { type: "japanese_man", trainer: "villain", word: "爽やか" },
      { type: "white_man", trainer: "villain", word: "髭" },
      { type: "donald_trump", trainer: "villain", word: "大統領" },
      { type: "emma_watson", trainer: "villain", word: "エマ" },
    ]
  end
end
