class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  skip_before_action :require_login, only: %i(index new create)

  #=====================================
  # GET:  /users
  #=====================================
  def index
    @users = User::all
  end

  #=====================================
  # GET:  /users/:id
  #=====================================
  def show
  end

  #=====================================
  # GET:  /users/new
  #=====================================
  def new
    @user = User.new
  end

  #=====================================
  # GET:  /users/:id/edit
  #=====================================
  def edit
  end

  #=====================================
  # POST: /users
  #=====================================
  def create
    @user = User.new user_params
    # create test
    if @user.save
      # success
      redirect_to :login, flash: {success: 'ユーザー登録に成功しました！'}
    else
      # error
      # TODO future:エラー詳細
      flash.now[:danger] = 'ユーザー登録に失敗しました！'
      render :new
    end
  end

  #=====================================
  # PUT:  /users/:id
  #=====================================
  def update
    # update test
    if @user.update(user_params)
      # success
      redirect_to :contents, flash: {success: 'ログイン情報を変更しました！'}
    else
      # error
      # TODO future:エラー詳細
      flash.now[:danger] = 'ログイン情報を変更できませんでした！'
      params[:action] = :edit.to_s
      render :edit
    end
  end

  #=====================================
  # DEL:  /users/:id
  #=====================================
  def destroy
    @user.destroy
    redirect_to :login, flash: {success: 'ユーザー情報を削除しました！'}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User::find params[:id]

    # user check
    if @user != current_user
      redirect_to :root, flash: {danger: '不正なアクセスです！'} and return
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit *%i(email password password_confirmation)
  end
end
