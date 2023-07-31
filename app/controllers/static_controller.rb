class StaticController < ApplicationController
  def contacts
  end

  def team
  end

  def welcome
    @user = params[:name]
  end
end
