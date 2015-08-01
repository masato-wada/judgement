class QuestionTag < ActiveRecord::Base

  belongs_to :question
  belongs_to :tag

  # tag_id 必須 半角数値のみ
  validates :tag_id, presence: { message: ValidationMessages::ESSENTIAL }
  validates :tag_id, numericality: { only_integer: true, greater_than_or_equal_to: 1, message: ValidationMessages::MANIPULATION }

end
