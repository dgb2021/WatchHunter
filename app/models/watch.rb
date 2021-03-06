class Watch < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo
  geocoded_by :postcode
  after_validation :geocode, if: :will_save_change_to_postcode?

  include PgSearch::Model
  pg_search_scope :search_by_name_and_brand,
    against: [ :name, :brand ],
    using: {
      tsearch: { prefix: true }
    }
end
