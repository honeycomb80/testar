class PagesController < ApplicationController

  def index
    if flash[:words].nil?
      @word = "Google, Apple, Facebook"
    else
      @word = flash[:words]
    end
    
  end

  def graph
    words = params[:getting][:search].split(%r{,})
    redirect_to pages_index_path
    flash[:words] = words[0]
  end

end
