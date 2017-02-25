class Testimonial < ActiveRecord::Base
  validates :story, :name, presence: true
end