class Category < ActiveRecord::Base

    # (add any attr_accessible here)
    acts_as_tree :order => 'name'

    serialize :fields, Hash

end
