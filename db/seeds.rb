# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

University.create({
    name: 'University of Cape Town',
    short_name: 'UCT',
    latitude: -33.9579019,
    longitude: 18.4611783
})

University.create({
    name: 'Stellenbosch University',
    short_name: 'SU',
    latitude: -33.932808,
    longitude: 18.864447
})
