class Question < ActiveRecord::Base

  has_many :selects
  accepts_nested_attributes_for :selects ,allow_destroy: true

  has_many :answers
  accepts_nested_attributes_for :answers ,allow_destroy: true

  has_many :question_tags
  accepts_nested_attributes_for :question_tags ,allow_destroy: true

  # title 必須 100文字以下
  validates :title, presence: { message: ValidationMessages::ESSENTIAL }
  validates :title, length: { minimum: 0, maximum: 100, message: '100' + ValidationMessages::CHAR_LENGTH }

  # desc 必須 300文字以下
  # validates :desc, presence: { message: ValidationMessages::ESSENTIAL }
  # validates :desc, length: { minimum: 0, maximum: 300, message: '300' + ValidationMessages::CHAR_LENGTH }

  def get_question_result
  end

end
