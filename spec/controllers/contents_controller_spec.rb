require 'rails_helper'

RSpec.describe ContentsController, type: :controller do
  let(:types){ Settings.types }

  #=======================================
  describe '#index' do
    subject { get :index }

    it 'content is empty' do
      Content::destroy_all
      expect(subject).to redirect_to action: :new
    end

    it 'setup @contents' do
      content = FactoryGirl::create :content
      subject
      expect(assigns :contents).to eq [content]
    end
  end

  #=======================================
  describe '#list' do
    before do
      @subject  = ->(type = :nil, name = :nil){
        get :list, params: { type: type, name: name }
      }
    end

    it ':type is illegal' do
      expect(@subject.call).to render_template :error
      expect(@subject.call).to have_http_status 400
    end

    it ':name is not found' do
      types.each{|type|
        expect(@subject.call type).to render_template :index
        expect(assigns :contents).to eq []
        expect(assigns :viewinfo).to eq({
          type: type.to_s,
          key:  Settings[:relations][type][:text],
          name: :nil.to_s
        })
      }
    end

    it 'each type list' do
      content = FactoryGirl::create :content
      types.each{|type|
        name    = content.names(type).first
        expect(@subject.call type, name).to render_template :index
        expect(assigns :contents).to eq [content]
      }
    end
  end

  #=======================================
  describe '#show' do
    before do
      @subject  = ->(id = 0){
        get :show, params: { id: id }
      }
    end

    it ':id is illegal' do
      ["", 0, -1].each{|data|
        expect(@subject.call data).to render_template :error
        expect(@subject.call data).to have_http_status 404
      }
    end

    it 'exist id' do
      content = FactoryGirl::create :content
      @subject.call content.id
      expect(assigns :content).to eq content
    end
  end

  #=======================================
  describe '#create' do
    it '409:deplicate check' do
      content = FactoryGirl::create :content
      expect(post :create, params: {url: content.url}).to have_http_status 409
      expect(JSON::parse response.body, symbolize_names: true).to match(
        status:   409,
        message:  an_instance_of(String)
      )
    end

    it '500:illegal url check' do
      content = FactoryGirl::create :content
      table   = {url: content.url}
      Content::destroy_all
      expect(post :create, params: table).to have_http_status 500
      expect(JSON::parse response.body, symbolize_names: true).to match(
        status:   500,
        message:  an_instance_of(String)
      )
    end

    it '200:success' do
      table   = {
        title:  'ONE PIECE',
        url:    'https://book.dmm.com/detail/b950bshes00487/',
        img:    'https://pics.dmm.com/digital/e-book/b950bshes00487/b950bshes00487pl.jpg'
      }
      expect(post :create, params: table).to have_http_status 200
      expect(JSON::parse response.body, symbolize_names: true).to match(
        status:   200,
        message:  be_empty,
        results:  /^\/contents\/\d+$/
      )
    end
  end

  #=======================================
  describe '#dmmsearch' do
    it 'dmm search' do
      expect(post :dmmsearch, params: {searchstr: '艦これ'}).to have_http_status 200
      expect(JSON::parse response.body, symbolize_names: true).to all match(
        title:  an_instance_of(String),
        url:    /\A#{URI::regexp(%w(http https))}\z/,
        img:    /\A#{URI::regexp(%w(http https))}\z/
      )
    end
  end

end
