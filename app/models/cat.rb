class Cat < ActiveRecord::Base
  COLORS = ["black", "gray", "white", "orange", "brown", "yellow"]

  validates :birth_date, :color, :name, :sex, presence: true
  validates_inclusion_of :sex, in: ["M", "F"]
  validates_inclusion_of :color, in: COLORS

  has_many(
    :requests,
    class_name: 'CatRentalRequest',
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )
  def age
    (Date.today - birth_date).to_i / 365
  end
end
