class ContentsController < ApplicationController

  # TODO varication

  #=====================================
  # GET:  /
  # GET:  /contents
  #   一覧表示
  #=====================================
  def index
    redirect_to action: :new and return if Content::blank?
    # TODO Content.empty => redirect #new
    # TODO page
    @contents = Content::all
  end

  #=====================================
  # GET:  /contents/search/:type/:searchstr
  #   検索結果画面表示
  #=====================================
  def search
    # type から Mstクラス生成
    klass = Content::master_class params[:type]
    # TODO varidate => type
    # if klass.nil?

    # 条件に合致するcontent_id一覧を取得
    ids   = klass
      .where(name: params[:searchstr])
      .map(&:content_ids)
      .flatten
      .uniq
    # TODO page

    # 表示対象のコンテンツ一覧を生成
    @contents = Content::where id: ids

    # 検索情報
    @searchinfo = {
      # 検索タイプ
      type: params[:type],
      # 検索タイプの文字化
      key:  Content::dig_relation(params[:type], :text),
      # 検索文字列
      str:  params[:searchstr],
    }

    # 描画設定
    params[:action] = :index
    render action: :index
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
    # TODO varidate => id
    @content  = Content::find params[:id]
    # if @content.nil?
  end

  #=====================================
  # POST: /contents
  #   新規登録処理
  #=====================================
  def create
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
    # search dmm contents
    data = DMMContent::search params[:searchstr]
    # TODO 登録済(registed)属性の追加
    render json: data.to_json and return
  end
end
