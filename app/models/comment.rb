class Comment < ActiveRecord::Base
  belongs_to :question
  belongs_to :select
  belongs_to :answer

  # question_id　必須 半角数値のみ
  validates :question_id, presence: { message: ValidationMessages::MANIPULATION }
  validates :question_id, numericality: { only_integer: true, greater_than_or_equal_to: 1, message: ValidationMessages::MANIPULATION }


  # comment 必須 100文字以下
  validates :comment, presence: { message: ValidationMessages::ESSENTIAL }
  validates :comment, length: { minimum: 0, maximum: 100, message: '100' + ValidationMessages::CHAR_LENGTH }
end
