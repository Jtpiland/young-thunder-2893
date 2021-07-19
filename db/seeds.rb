universal = Studio.create(name: 'Universal Studios', location: 'Hollywood')

raiders = universal.movies.create(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
shrek = universal.movies.create(title: 'Shrek', creation_year: 2001, genre: 'Comedy')

harrison = raiders.actors.create!(name: 'Harrison Ford', age: 78)
alfred = raiders.actors.create!(name: 'Alfred Molina', age: 68)
denholm = Actor.create!(name: 'Denholm Elliott', age:70)
