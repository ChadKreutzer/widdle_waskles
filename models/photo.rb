class Photo < ActiveRecord::Base
  validates :before_filename, :after_filename, :caption, presence: true
end