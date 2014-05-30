class Pledge < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true

  validates :email, format: {
    with:    /\S+@\S+/i,
    message: "must contain a valid email"
  }

  AMOUNT_LEVELS = [25.00, 50.00, 100.00, 200.00, 500.00]

  validates :pledge_amount, inclusion: { in: AMOUNT_LEVELS }
end
