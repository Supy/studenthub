class Advert < ActiveRecord::Base
    """
    An Advert is an individual item being sold/given away. The advert has a
    :title, :description, and :category_id along with :field_values that match
    the field definition for its category, and a :price_type that encodes one
    of [exact, free, swap, poa], the :price variable is only needed if
    :price_type is exact
    """

    # has a category
    belongs_to :category

    # field_values is a Hash
    serialize :field_values, Hash

    # price_type is an enum
    enum price_type: [:exact_price, :free, :swap, :price_on_application]

    validates :title, presence: true, allow_blank: false
    validates :title, length: {minimum: 5, maximum: 100}
    validates :description, presence: true, allow_blank: false
    validates :description, length: {minimum: 10, maximum: 10000}

end
