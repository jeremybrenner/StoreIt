class SimpleReceiptsController < ApplicationController
  
  before_action :require_token

  rescue_from ActiveRecord::RecordNotFound, with: :bad_token

  # this creates the API endpoint for JSON receipts
  # having both formats allows handling for html requests and json
  def index
  	@receipts = current_owner.simple_receipts
  	respond_to do |f|
  		f.html { render json: @receipts}
  		f.json { render json: @receipts}	
  	end
  end

  def new
  	@receipt = SimpleReceipt.new
  end

  def create
  	@receipt = current_owner.simple_receipts.create(receipt_params)
 	respond_to do |f|
 		f.html { render json: @receipt }
 		f.json { render json: @receipt }	
 	end
  end


  protected

  def bad_token(error)
  	render json: { status: 401, errors: e.message}, status: 401
  end

  private

  def receipt_params
  	params.require(:simple_receipt).permit(:transaction_num, :total, :amount,:tip)
  end

  def require_token
  	# this is to allow token identification regardless of input params
	  if params[:api_token]
	  	api_token = params[:api_token] 
	  else
	  	api_token = current_owner.api_token
	  end
	  @current_owner = StoreOwner.find_by!(api_token: api_token)
	end
end
