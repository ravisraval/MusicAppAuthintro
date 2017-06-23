class Track < ApplicationRecord
  validates :album_id, :name, :bonus, :lyrics, presence: true

  belongs_to :album
  # delegate : bands somehow
end
