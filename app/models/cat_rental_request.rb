class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  after_initialize :set_status_pending
  validates_inclusion_of :status, in: ["PENDING", "APPROVED", "DENIED"]
  validate :cannot_overlap_with_approved_requests

  belongs_to(
    :cat,
    class_name: 'Cat',
    foreign_key: :cat_id,
    primary_key: :id
  )

  def overlapping_requests
    CatRentalRequest
    .where("id != ? AND cat_id = ? AND
          ((start_date BETWEEN ? AND ?)
          OR (end_date BETWEEN ? AND ?))",
          id, cat_id, start_date, end_date, start_date, end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end


  def set_status_pending
    status ||= "PENDING"
  end

  private

  def cannot_overlap_with_approved_requests
    if self.overlapping_approved_requests.any?
      [errors: base] << "There is an overlapping approved request."
    end
  end
end
