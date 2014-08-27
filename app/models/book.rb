class Book < ActiveRecord::Base
    has_many :isbns, dependent: :delete_all

    accepts_nested_attributes_for :isbns

    validates :title, presence: true
    validates :author, presence: true
end
