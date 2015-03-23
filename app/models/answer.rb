class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :select

  # select_id 必須 半角数値のみ
  validates :select_id, presence: { message: ValidationMessages::ESSENTIAL }
  validates :select_id, numericality: { only_integer: true, greater_than_or_equal_to: 1, message: ValidationMessages::MANIPULATION }

end
