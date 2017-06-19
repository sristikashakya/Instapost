class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :is_owner?, only: [:edit, :update, :delete]
	def new
		@post = Post.new
	end

	 def create
  	  @post = current_user.posts.create(post_params)
        if @post.valid?
        	redirect_to root_path
        else
        render :new, status: :unprocessable_entity
        end
    end

    def show
        @posts = Post.find(params[:id])
    end

    def index
      if user_signed_in?
        @posts = Post.all.order('created_at DESC').includes(:user, comments: :user).paginate(page: params[:page], per_page: 2)
      else
        @posts = Post.all.order('created_at DESC').includes(:user, comments: :user).paginate(page: params[:page])
      end
    end

    def edit
    	   @post = Post.find(params[:id])
    end

    def update
    	  @post = Post.find(params[:id])
    	  @post.update(post_params)
    	  if @post.valid?
      	 redirect_to root_path
    	  else
        	render :edit, status: :unprocessable_entity
        end
	  end
	def destroy
  		@post = Post.find(params[:id])
  		@post.destroy
  		redirect_to root_path
	end
  def browse
      @posts = Post.all.order('created_at DESC').page params[:page]
  end
  
    private
		def is_owner?
		  redirect_to root_path if Post.find(params[:id]).user != current_user
		end
		def post_params
			params.require(:post).permit(:user_id, :photo, :description)
		end
end
