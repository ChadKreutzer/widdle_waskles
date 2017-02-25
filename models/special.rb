class Special < ActiveRecord::Base
  validates :headline, :offer, :expires, presence: true
end