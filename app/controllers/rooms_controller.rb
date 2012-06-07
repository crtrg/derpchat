class RoomsController < ApplicationController
  def create
    redirect_to room_path(params[:room])
    session[:user] = params[:user]
  end

  def show
    @room = params[:id]
    @user = session[:user]
  end
end
