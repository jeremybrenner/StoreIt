class SessionsController < ApplicationController

	rescue_from ActiveRecord::RecordNotFound, with: :failed_login

	def new
		@store_owner = StoreOwner.new
	end

	def create
		@store_owner = StoreOwner.confirm(session_params)
		login(@store_owner)
		redirect_to "/account"
	end

	def destroy
		logout
		redirect_to "/"
	end

	protected

	def failed_login(e)
		flash[:error] = "Invalid Login Dawg"
		redirect_to "/login"
	end

	private

	def session_params
		params.require(:store_owner).permit(:email, :password)
	end
end
