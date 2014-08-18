class University < ActiveRecord::Base

    validates :name, presence: true, allow_blank: false, length: { minimum: 3 }, uniqueness: true
    validates :short_name, presence:true, allow_blank: false, length: {minimum: 1}, uniqueness: true

    validates :latitude, presence: true, numericality: { less_than: 90, greater_than: -90 }
    validates :longitude, presence: true, numericality: { less_than: 90, greater_than: -90 }

end
