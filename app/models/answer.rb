class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :select

  # タイトル 必須 100文字以下 全角のみ
  validates :select_id, presence: { message: '入力必須項目です' }

end
