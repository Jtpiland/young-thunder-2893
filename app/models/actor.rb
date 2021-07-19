class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.list_by_youngest_age
    order(age: :asc)
  end

  def self.avg_age
    average(:age)
  end

end
