class Cat < ActiveRecord::Base
  COLORS = ["black", "gray", "white", "orange", "brown", "yellow"]

  validates :birth_date, :color, :name, :sex, :user_id, presence: true
  validates :sex, inclusion: { in: ["M", "F"] }
  validates :color, inclusion: { in: COLORS }

  has_many(
    :requests,
    class_name: 'CatRentalRequest',
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  belongs_to :owner,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  def age
    (Date.today - birth_date).to_i / 365
  end
end
