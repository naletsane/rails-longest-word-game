require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = generate_new (10)
  end

  def score
    # @word = params[:word].upcase
    @letters = params[:letters]
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)

  end

  def generate_new(number)
    charset = Array ("A".."Z")
    Array.new(number) {charset.sample}.join
  end

  private

  def included?(word, letters)
    # word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
