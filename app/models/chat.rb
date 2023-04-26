class Chat < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    scope :search, -> (keyword) {
    where("title ILIKE :keyword", keyword: "%#{keyword}%") if keyword.present?
  }
end
