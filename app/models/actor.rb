class Actor < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :birth_date }
  validates :birth_date, presence: true
end
