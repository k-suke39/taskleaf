class SessionsController < ApplicationController
  skip_before_action :login_required
  
  def new
  end

  def create
    user = user.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました'
    else
      redner :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private

  def task_params
    params.require(:task).permit(:email,:password)
  end
end
