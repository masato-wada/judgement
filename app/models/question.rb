class Question < ActiveRecord::Base

  has_many :selects
  accepts_nested_attributes_for :selects ,allow_destroy: true

  has_many :answers
  accepts_nested_attributes_for :answers ,allow_destroy: true

  # タイトル 必須 100文字以下
  validates :title, presence: { message: '入力必須項目です' }
  validates :title, length: { minimum: 0, maximum: 100, message: '100文字以内で入力ください'}

  #  必須 300文字以下
  validates :desc, presence: { message: '入力必須項目です' }
  validates :desc, length: { minimum: 0, maximum: 300, message: '300文字以内で入力ください'}

end
