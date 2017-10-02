class ContentsController < ApplicationController

  #=====================================
  # GET:  /
  # GET:  /contents
  #   一覧表示
  #=====================================
  def index
    # empty check
    redirect_to action: :new and return if Content::blank?
    # TODO pager
    @contents = Content::all
  end

  #=====================================
  # GET:  /contents/list/:type/:name
  #   リスト画面表示
  #=====================================
  def list
    # type から Mstクラス生成
    klass = Content::master_class params[:type]
    # varidate => type
    render action: :error, status: 400 and return if klass.nil?

    # 条件に合致するcontent_id一覧を取得
    ids   = klass
      .where(name: params[:name])
      .map(&:content_ids)
      .flatten
      .uniq
    # TODO pager

    # 表示対象のコンテンツ一覧を生成
    @contents = Content::where id: ids

    # 検索情報
    @viewinfo = {
      # 検索タイプ
      type: params[:type],
      # 検索タイプの文字化
      key:  Content::dig_relation(params[:type], :text),
      # 指定文字列
      name: params[:name],
    }

    # 描画設定
    params[:action] = :index
    render action: :index
  end

  #=====================================
  # POST: /contents/search
  #   検索結果画面表示
  #=====================================
  def search
    # TODO varidate => type / searchstr
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
    @content  = Content::find_by_id params[:id]
    render action: :error, status: 404 and return if @content.nil?
  end

  #=====================================
  # POST: /contents
  #   新規登録処理
  #=====================================
  def create
    # request params hash table
    table = params.to_unsafe_hash.symbolize

    # exist check and error response
    render json: Resjon::error409 and return if Content::exist? url: table[:url]

    # search content detail
    data  = table.merge DMMContent::detail table[:url]

    # regist data
    record= Content::regist data

    # deplicate check and error response
    render json: Resjon::error500 and return if record.nil?

    # normal response
    url = url_for only_path: true, action: :show, id: record.id
    render json: Resjon::normal(url) and return
  end

  #=====================================
  # POST: /api/search
  #   DMMコンテンツ検索
  #=====================================
  def dmmsearch
    # search dmm contents
    data = DMMContent::search params[:searchstr]
    # TODO 登録済(registed)属性の追加
    render json: data.to_json and return
  end
end
