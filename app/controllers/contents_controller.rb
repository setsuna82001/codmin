class ContentsController < ApplicationController

  # TODO varication

  #=====================================
  # GET:  /
  # GET:  /contents
  #   一覧表示
  #=====================================
  def index
    # TODO Content.empty => redirect #new
  end

  #=====================================
  # GET:  /contents/search/:type/:searchstr
  #   検索結果画面表示
  #=====================================
  def search
    # TODO varidate => type searchstr
  end

  #=====================================
  # GET:  /contents/new
  #   コンテンツ検索/登録
  #=====================================
  def new
  end

  #=====================================
  # GET:  /contents/:id
  #   詳細表示
  #=====================================
  def show
    @content  = Content::find params[:id]

    url = url_for action: :new, id: 3
    @content  = {url: url}

    render json: @content.to_json and return
  end

  #=====================================
  # POST: /contents
  #   新規登録処理
  #=====================================
  def create
    # TODO varidate => title / url / img
    data  = params.to_unsafe_hash.symbolize

    # exist check
    render json: Resjon::error409 and return if Content::exist? url: data[:url]

    # search content detail
    data  = data.merge DMMContent::detail data[:url]

    # regist data
    record= Content::regist data

    # deplicate response
    render json: Resjon::error500 and return if record.nil?

    # normal response
    url = url_for only_path: true, action: :show, id: record.id
    render json: Resjon::normal(url) and return
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
