require 'open-uri'

class GamesController < ApplicationController

  def new
    # used to display a new random grid and a form
    @letters = []
    alphabet = ('a'..'z').to_a
    10.times do
      n = rand(0..25)
      @letters << alphabet[n]
    end
  end

  def score
    # The form will be submitted (with POST) to the score action.
    answer = params[:answer]
    letters_offered = params[:letters_offered]

    @used_correct_letters = true
    splitted = answer.split('')
    splitted.each { |letter| @used_correct_letters = false unless letters_offered.include?(letter) }

    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    data_serialized = open(url).read
    parsing_result = JSON.parse(data_serialized)
    @result = parsing_result['found']



  end

end
