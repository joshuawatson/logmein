class SessionsController < ApplicationController
  PUBLIC_ACTIONS = %w(new create)

  def new
    @session = Session.new
  end

  def create
    next_url = session[:return_to] || home_url
    @session = Session.new params[:session]
    if @session.save
      session.delete :return_to
      flash[:notice] = "Successfully logged in."
      redirect_to next_url
    else
      render :action => 'new'
    end
  end

  def destroy
    @session = Session.find
    @session.destroy
    reset_session
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end