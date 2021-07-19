require 'rails_helper'

RSpec.describe 'Studio Index Page' do
  before :each do
    @universal = Studio.create(name: 'Universal Studios', location: 'Hollywood')
    @universal.movies.create(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @universal.movies.create(title: 'Shrek', creation_year: 2001, genre: 'Comedy')

    visit '/studios'
  end

#   As a user,
# When I visit the studio index page
# I see a each studio's name and location
# And underneath each studio, I see the titles of all of its movies.
  it 'can display the name and location of each studio' do

    expect(page).to have_content("#{@universal.name}")
    expect(page).to have_content("#{@universal.location}")
  end

  it 'can display the titles of all the movies from each studio' do

    expect(page).to have_content('Raiders of the Lost Ark')
    expect(page).to have_content('Shrek')
  end
end
