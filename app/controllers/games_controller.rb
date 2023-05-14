require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    return @letters
  end

  def score
    word = params[:word].upcase
    letters = params[:letters].split('')

    if word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
      url = "https://wagon-dictionary.herokuapp.com/#{word}"
      response = URI.open(url).read
      json = JSON.parse(response)
      word_found = json['found']

      if word_found
        @output = "Congratulations! #{word} is a valid English word"
      else
        @output = "#{word} is not an English word."
      end
    else
      @output = "#{word} can't be built out of #{letters.join(', ')}"
    end
  end
end
