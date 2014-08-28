class Textbook < ActiveRecord::Base
    belongs_to :book

    enum condition: { poor: 10, ok: 20, good: 30, perfect: 40 }

    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 30_000, allow_blank: false }
    validates :edition, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, allow_blank: false }
    validates :condition, presence: true

end
