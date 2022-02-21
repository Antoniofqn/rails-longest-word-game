require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters_array = []
    10.times do
      @letters_array << ("a".."z").to_a.sample
    end
    @letters_array
  end

  def score
    @result = "Sorry, but #{params[:answer]} is not a real word" if word_is_valid(params[:answer]) == false
    @result = "sorry, but '#{params[:answer]}' cant be made with '#{params[:letters]}'" if in_grid(params[:answer], params[:letters]) == false
    @result = "Congratulations! '#{params[:answer].capitalize}' is a valid english word!"
  end

  def in_grid(answer, grid)
    attup = answer.upcase
    att_array = attup.chars
    att_array.each do | letter |
    if grid.include?(letter)
      grid.delete_at(grid.index(letter))
    else
      return false
    end
  end

  end

  def word_is_valid(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    word_data_serialized = URI.open(url).read
    word_data = JSON.parse(word_data_serialized)
    if word_data["found"] == true
      return true
    else
      return false
    end
  end
end
