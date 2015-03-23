class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :user_id, presence: true
  after_initialize :set_status_pending
  validates :status, inclusion: {in: ["PENDING", "APPROVED", "DENIED"]}
  validate :cannot_overlap_with_approved_requests

  belongs_to(
    :cat,
    class_name: 'Cat',
    foreign_key: :cat_id,
    primary_key: :id
  )

  belongs_to(
    :user,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id
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

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end


  def set_status_pending
    self.status ||= "PENDING"
  end

  def approve!
    CatRentalRequest.transaction do
      self.update!(status: "APPROVED")
      overlapping_pending_requests.each do |req|
        req.deny!
      end
    end
  end

  def deny!
    self.update!(status: "DENIED")
  end

  private

  def cannot_overlap_with_approved_requests
    if self.overlapping_approved_requests.any?
      errors[:base] << "There is an overlapping approved request."
    end
  end
end
