class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  #=====================================
  # GET:  /sessions/new
  # GET:  /login
  #=====================================
  def new
    # empty check
    redirect_to controller: :users, action: :new and return unless User::any?
    # set variables
    @user = User.new
  end

  #=====================================
  # POST: /sessions
  #=====================================
  def create
    if @user = login(params[:email], params[:password])
      redirect_to :contents, flash: {success: 'ログインしました！'}
    else
      # TODO future:エラー詳細
      flash.now[:danger] = 'ログインに失敗しました！'
      render action: :new
    end
  end

  #=====================================
  # DEL:  /sessions/:id
  # GET:  /logout
  #=====================================
  def destroy
    logout
    redirect_to :login, flash: {success: 'ログアウトしました！'}
  end
end
