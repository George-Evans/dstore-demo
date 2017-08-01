class CommentsController < ApplicationController
	load_and_authorize_resource
	

	def create
		@product = Product.find(params[:product_id])
		@comment = @product.comments.new(comment_params)
		@comment.user = current_user
		@user = current_user
		respond_to do |format|
			if @comment.save
				ProductChannel.broadcast_to @product.id, comment: CommentsController.render(partial: "comments/comment", locals: {comment: @comment, current_user: current_user}), average_rating: @product.average_rating
				@product.set_latest_reviewer("#{@user.first_name}")
				format.html { redirect_to @product, notice: "Review was created sucessfully." }
				format.json { render :show, status: :created, location: @product }
				format.js
			else
				format.html { redirect_to @product, alert: "Review was not save sucessfully." }
				format.json { render json: @comment.error, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		product = @comment.product
		@comment.user = current_user
		@comment.destroy
		redirect_to product
	end

	private

		def comment_params
			params.require(:comment).permit(:user_id, :summary, :body, :rating)
		end

end
