class AccountActivationsController < ApplicationController
  def edit
  	user = User.find_by(email: params[:email])
  	if user && !user.activated? && user.authenticated?(:activation, params[:id])
  		user.activate
  		flash[:success] = "Your account is activated and you can make a f#ckton"
  		log_in user
  		redirect_to user
  	else
  		flash[:danger] = "Your activation link is invalid"
  		redirect_to root_url
  	end
  end
end
