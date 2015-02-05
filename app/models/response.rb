class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true
end
