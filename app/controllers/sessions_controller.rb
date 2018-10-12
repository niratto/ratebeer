# frozen_string_literal: true

# top level comment
class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    # tarkastetaan että käyttäjä olemassa, ja että salasana on oikea
    if user&.authenticate(params[:password])
      if !user.active?
        redirect_to signin_path, notice: 'Admin has deactivated your account!'
      else
        session[:user_id] = user.id
        redirect_to user_path(user), notice: 'Welcome back!'
      end
    else
      redirect_to signin_path, notice: 'Username and/or password mismatch'
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end

  def megadeth
    if session[:user_id]
      u = User.find(session[:user_id])
      u.ratings.destroy_all
      u.destroy
      session[:user_id] = nil
    end
    redirect_to :root, notice: 'User was deleted!'
  end
end
