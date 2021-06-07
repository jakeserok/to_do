class Task < ApplicationRecord
  belongs_to :goal

  validates_presence_of :item
  validates_presence_of :description
end
