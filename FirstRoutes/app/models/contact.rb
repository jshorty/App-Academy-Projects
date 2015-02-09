class Contact < ActiveRecord::Base
  validates :email, :user_id, :name, :presence => true
  validates :email, :uniqueness => {:scope => :user_id} 


end
