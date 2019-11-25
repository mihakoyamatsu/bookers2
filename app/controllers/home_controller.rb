class HomeController < ApplicationController
  def top
  flash[:notice]= 'signed out successfully.'
  end

  def about
  end
end
