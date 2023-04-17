class Team < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :plan_id, scope: :user_id
  with_options presence: true do
    validates :user_id
    validates :customer_id
    validates :active_until
    validates :stripe_subscription_id
    validates :plan_id
  end
end
