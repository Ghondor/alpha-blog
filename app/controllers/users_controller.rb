class UsersController < ApplicationController
    def index
        @users = User.page(params[:page]).per(5)
    end
    
    def show
        @user = User.find(params[:id])
        @user_articles = @user.articles.page(params[:page])
        # @user.articles.page(1).total_pages = 5
        # @user_articles = Kaminari.paginate_array(@user.articles)
    end
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Your account has been updated successfully"
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    private
        def user_params
            params.require(:user).permit(:username, :email, :password)
        end
end