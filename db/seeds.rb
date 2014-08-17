# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Creating some predefined categories to seed the database
books = Category.create({
    name: 'Books',
    fields: {
        'Title' => {required: true},
        'Author' => {required: true},
        'Publisher' => {},
        'Quality' => {}
    }
})

textbooks = Category.create({
    name: 'Textbooks',
    parent: books,
    fields: {
        'ISBN' => {},
        'Subject' => {},
        'Edition' => {}
    }
})
