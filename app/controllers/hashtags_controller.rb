# frozen_string_literal: true

class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:text])
  end
end
