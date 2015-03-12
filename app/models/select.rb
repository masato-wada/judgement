class Select < ActiveRecord::Base

  belongs_to :question

  # タイトル 必須 100文字以下 全角のみ
  validates :desc, presence: { message: '入力必須項目です' }
  validates :desc, length: { minimum: 0, maximum: 100, message: '100文字以内で入力ください'}

end
