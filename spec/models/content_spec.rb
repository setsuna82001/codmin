require 'rails_helper'

RSpec.describe Content, type: :model do
  let(:types){ Settings.types }

  #=======================================
  # Content::dig_relation
  #=======================================
  it '::dig_relation' do
    # not exist key
    expect(Content::dig_relation :nil).to be_nil

    types.each{|type|
      # main key only
      expect(Content::dig_relation type).to eq Settings[:relations][type]
      # sub key
      expect(Content::dig_relation type, :text).to eq Settings[:relations][type][:text]
      # not exist key
      expect(Content::dig_relation type, :nil).to be_nil
    }
  end

  #=======================================
  # Content::master_class
  #=======================================
  it '::master_class' do
    # not exist key
    expect(Content::master_class :nil).to be_nil

    # each type
    expect(Content::master_class :author).to eq MstAuthor
    expect(Content::master_class :tag).to eq MstTag
  end

  #=======================================
  # Content::regist
  #=======================================
  it '::regist' do
    # regist data table
    table = {
      title:  'test-title',
      url:    'http://test.url/',
      img:    'http://test.img/',
      authors:  %w(test_author0 test_author1 test_author2),
      tags:     %w(test_tag0 test_tag1 test_tag2)
    }

    # return check
    data  = Content::regist table
    expect(data).to match an_instance_of Content

    # deplicate check
    dummy = table.merge({
      title:  'test-title-dummy',
      img:    'http://test.img/dummy'
    })
    expect{Content::regist dummy}.to raise_error ActiveRecord::RecordNotUnique

    # other data return check
    dummy = table.merge({
      url:    'http://test.url/dummy',
    })
    expect(Content::regist dummy).to match an_instance_of Content
  end

  #=======================================
  describe do
    let(:content){ FactoryGirl::create :content }

    #=====================================
    # Content#dig_relation
    #=====================================
    it '.dig_relation' do
      # not exist key
      expect(content.dig_relation :nil).to be_nil

      types.each{|type|
        # main key only
        expect(content.dig_relation type).to eq Settings[:relations][type]
        # sub key
        expect(content.dig_relation type, :text).to eq Settings[:relations][type][:text]
        # not exist key
        expect(content.dig_relation type, :nil).to be_nil
      }
    end

    #=====================================
    # Content#masters
    #=====================================
    it '.masters' do
      # not exist key
      expect(content.masters :nil).to be_nil

      # author side
      expect(content.masters :author ).to eq content.mst_authors
      expect(content.masters :authors).to eq content.mst_authors

      # tag side
      expect(content.masters :tag ).to eq content.mst_tags
      expect(content.masters :tags).to eq content.mst_tags
    end

    #=====================================
    # Content#regist_subtable
    #=====================================
    it '.regist_subtable' do
      # not exist key
      expect{content.regist_subtable :nil, []}.to raise_error TypeError

      types.each{|type|
        # not array
        expect{content.regist_subtable type, nil}.to raise_error TypeError

        # regist empty list
        list  = content.names type
        content.regist_subtable type, []
        expect(content.names type).to eq list

        # regist deplicate list
        content.regist_subtable type, list
        expect(content.names type).to eq list

        # regist new text
        data  = %w(test)
        content.regist_subtable type, data
        expect(content.names type).to eq (list + data)
      }
    end

    #=====================================
    # Content#names
    #=====================================
    it '.names' do
      # not exist key
      expect(content.names :nil).to be_empty

      # author side
      list  = content.mst_authors.map &:name
      expect(content.names :author ).to eq list
      expect(content.names :authors).to eq list

      # tag side
      list  = content.mst_tags.map &:name
      expect(content.names :tag ).to eq list
      expect(content.names :tags).to eq list
    end

    #=====================================
    # Content#***_names
    #=====================================
    it '.***_names' do
      # not exist key
      expect(content.nil_names).to be_empty

      # author side
      list  = content.mst_authors.map &:name
      expect(content.author_names ).to eq list
      expect(content.authors_names).to eq list

      # tag side
      list  = content.mst_tags.map &:name
      expect(content.tag_names ).to eq list
      expect(content.tags_names).to eq list
    end
  end
end
