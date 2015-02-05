class AnswerChoice < ActiveRecord::Base
  validates :text, :question_id, presence: true
  validates :text, :uniqueness => {:scope => :question}
end
