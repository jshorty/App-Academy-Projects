class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  # validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll


  belongs_to :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    self.question.responses.where(":id IS NULL OR responses.id != :id", {id: self.id})
  end

  private
    def respondent_has_not_already_answered_question
      if self.sibling_responses.exists?(user_id: self.user_id)
        errors[:base] << "Already answered this question!"
      end
    end

    def author_cannot_respond_to_own_poll
      if self.question.poll.author_id == user_id
        errors[:base] << "Can't answer your own poll"
      end
    end
end
