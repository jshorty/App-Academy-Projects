class Cat < ActiveRecord::Base
  COLORS = ["black", "gray", "white", "orange", "brown", "yellow"]

  validate :birth_date, :color, :name, :sex, presence: true
  validates_inclusion_of :sex, in: ["M", "F"]
  validates_inclusion_of :color, in: COLORS

  def age
    (Date.today - birth_date).to_i / 365
  end
end
