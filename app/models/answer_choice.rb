class AnswerChoice < ActiveRecord::Base
  validates :text, :question_id, presence: true
  validates :text, :uniqueness => {:scope => :question}

  belongs_to :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id,
    dependent: :destroy

  after_destroy :log_destroy_action
  def log_destroy_action
    puts "#{self.class} destroyed."
  end
end
