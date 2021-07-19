require 'rails_helper'

RSpec.describe 'Movies Show Page' do
  before :each do
    @universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @raiders = @universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @shrek = @universal.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Comedy')
    @harrison = @raiders.actors.create!(name: 'Harrison Ford', age: 78)
    @alfred = @raiders.actors.create!(name: 'Alfred Molina', age: 68)
    @denholm = Actor.create!(name: 'Denholm Elliott', age:70)

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

#   As a user,
# When I visit a movie show page,
# I do not see any actors listed that are not part of the movie
# And I see a form to add an actor to this movie
# When I fill in the form with the name of an actor that exists in the database
# And I click submit
# Then I am redirected back to that movie's show page
# And I see the actor's name is now listed
  it 'has a form to add an existing actor to a movie' do

    expect(page).to have_content('Add Actor To Movie')
    expect(find('form')).to have_content('Name')
  end

  it 'redirects back to the movies show page and lists the new actor' do
    fill_in 'Name', with: 'Denholm Elliott'

    click_button 'Add Actor'

    expect(current_path).to eq("/movies/#{@raiders.id}")
    expect(page).to have_content('Denholm Elliott')
  end
end
