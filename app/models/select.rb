class Select < ActiveRecord::Base

  belongs_to :question

  has_many :answers
  accepts_nested_attributes_for :answers ,allow_destroy: true

  # desc 必須 100文字以下 全角のみ
  validates :desc, presence: { message: ValidationMessages::ESSENTIAL }
  validates :desc, length: { minimum: 0, maximum: 100, message: '100' + ValidationMessages::CHAR_LENGTH }

end
