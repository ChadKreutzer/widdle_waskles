class Service < ActiveRecord::Base
  validates :task, :species, presence: true
end