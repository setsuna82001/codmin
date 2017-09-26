class ContentsController < ApplicationController

  # TODO varication

  #=====================================
  # 一覧表示
  #=====================================
  def index
  end

  #=====================================
  # 検索/登録画面
  #=====================================
  def new
  end

  #=====================================
  # 詳細表示
  #=====================================
  def show
  end

  #=====================================
  # 新規登録処理
  #=====================================
  def create
    # TODO varidate => url
    data = data.merge DMMContent::detail data[:url]

    render json: data.to_json
  end

  #=====================================
  #
  #=====================================
  def search
    # TODO varidate => type searchstr
  end

  #=====================================
  # POST: /api/search
  #=====================================
  def dmmsearch
    # TODO varidate => searchstr
    # search dmm contents
    data = DMMContent::search params[:searchstr]
    # TODO 登録済(registed)属性の追加
    render json: data.to_json and return
  end
end
