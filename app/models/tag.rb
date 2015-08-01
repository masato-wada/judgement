class Tag < ActiveRecord::Base

  has_many :question_tags
  accepts_nested_attributes_for :question_tags ,allow_destroy: true

end
