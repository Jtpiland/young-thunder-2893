require 'rails_helper'

RSpec.describe 'Movies Show Page' do
  before :each do
    @universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @raiders = @universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @shrek = @universal.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Comedy')
    @harrison = @raiders.actors.create!(name: 'Harrison Ford', age: 78)
    @alfred = @raiders.actors.create!(name: 'Alfred Molina', age: 68)

    visit "/movies/#{@raiders.id}"
  end
# As a user,
# When I visit a movie's show page.
# I see the movie's title, creation year, and genre,
# and a list of all its actors from youngest to oldest.
# And I see the average age of all of the movie's actors
  it 'can list all the attributes of a particular movie' do

    expect(page).to have_content("#{@raiders.title}")
    expect(page).to have_content("#{@raiders.creation_year}")
    expect(page).to have_content("#{@raiders.genre}")
    expect(page).to_not have_content("#{@shrek.title}")
  end

  it 'can list all the actors in that movie in alphabetical order' do
    
    expect(page).to have_content(@harrison.name)
    expect(page).to have_content(@alfred.name)
    expect(@alfred.name).to appear_before(@harrison.name)
  end

  it 'can show the average age of the movies actors' do

  expect(page).to have_content('Average Age of Actors')
  expect(@raiders.actors.avg_age).to eq(73)
  end
end
