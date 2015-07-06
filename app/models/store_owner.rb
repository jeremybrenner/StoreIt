class StoreOwner < ActiveRecord::Base

	has_many :simple_receipts

	has_secure_password

	before_validation :gen_api_token, :on => :create

	validates :api_token,
			  :uniqueness => true

	validates :email,
			  :presence => true,
			  :uniqueness => true

	  

	def self.confirm(params)
		store_owner = self.find_by!(email: params[:email])
		store_owner.authenticate(params[:password])
	end

	def gen_api_token
		token = SecureRandom.uuid

		until StoreOwner.find_by(api_token: token).nil?
			token = SecureRandom.uuid
		end

		self.api_token = token

		def confirm_token(params)
			if params[:api_token]
				token = params[:api_token]
			else
				token = current_user.api_token
			end
			store_owner = StoreOwner.find_by!(api_token: token)
		end

	end

end
