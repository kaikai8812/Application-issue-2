class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
	
	def authenticate_user 
	  if current_user.nil?
	    redirect_to new_user_session_path
	  end
	end

  def check_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end
  
   def check_book
     @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
   end
  
  protected
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
