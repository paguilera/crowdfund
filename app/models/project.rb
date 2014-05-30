class Project < ActiveRecord::Base

  has_many :pledges, dependent: :destroy

  validates :name, :description, presence: true

  validates :description, length: { maximum: 500 }

  validates :target_pledge_amount, numericality: { greater_than: 0 }

  validates :website, allow_blank: true, format: {
    with:    /https?\:\/\/.+/i,
    message: "must contain a valid website"
  }

  validates :image_file_name, allow_blank: true, format: {
    with:    /\w+.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }

  def self.accepting_pledges
    where("pledging_ends_on >= ?", Time.now).order("pledging_ends_on asc")
  end

  def pledging_expired?
    pledging_ends_on < Date.today
  end

  def total_amount_pledged
    pledges.sum(:pledge_amount)
  end

  def amount_outstanding
    target_pledge_amount - total_amount_pledged
  end

  def funded?
    amount_outstanding.zero?
  end
end
