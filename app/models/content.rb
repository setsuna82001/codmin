class Content < ApplicationRecord
  # tag side
  has_many :tags, dependent: :destroy
  has_many :mst_tags, through: :tags

  # author side
  has_many :authors, dependent: :destroy
  has_many :mst_authors, through: :authors

  validates :title, length: {minimum: 1}
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :img, format: /\A#{URI::regexp(%w(http https))}\z/


  class << self
    #===================================
    # Content::dig_relation
    #   Settings[:relations] の中を掘って返す
    #===================================
    def dig_relation type, *args
      Settings[:relations].dig *[type, *args].flatten
    end

    #===================================
    # Content::master_class
    #   Master*** のクラスを返す
    #===================================
    def master_class type
      name  = dig_relation type, *%i(model master)
      return nil if name.nil?
      klass = Kernel::const_get name
    end

    #===================================
    # Content::regist
    #   子テーブルまで登録するメソッド
    #===================================
    def regist data
      ActiveRecord::Base.transaction do
        # content に 登録するデータ
        table = %i(title url img).inject([]){|arr, key|
          next arr.push [key, data[key]]
        }.to_h

        # create
        record = self.create table

        # create sub tables
        Settings[:types].each{|type|
          symbol = type.to_s.pluralize.to_sym
          record.regist_subtable symbol, data[symbol]
        }

        # return record data
        record
      end
    end
  end

  #=====================================
  # Content#dig_relation
  #   クラスメソッドのラッパー
  #=====================================
  def dig_relation type, *args
    self.class::dig_relation type, *args
  end


  #=====================================
  # Content#masters
  #   自身のmst_***s を返す
  #=====================================
  def masters type
    # make receiver
    name      = self.dig_relation type, *%i(relation master)
    return nil if name.nil?
    receiver  = self.send name
  end

  #=====================================
  # Content#regist_subtable
  #   サブテーブルのレコード登録
  #=====================================
  def regist_subtable type, list
    # make receiver
    receiver  = self.masters type
    # make master class
    klass     = self.class::master_class type
    # object check
    raise TypeError, "type=#{type} is Not Accept" if receiver.nil? || klass.nil?
    raise TypeError, "list is Array Only" unless Array === list

    # regist each data
    list.each{|text|
      # deplicate check
      record  = klass::find_or_create_by name: text.to_s
      next if receiver.include? record
      # record.mst_tags << MstTag::find_or_create_by
      receiver << record
    }
  end

  #=====================================
  # Content#names
  # masters_***s の テキストデータを返す
  #=====================================
  def names type
    # make receiver
    receiver = self.masters type
    return [] if receiver.nil?
    # rteturn names
    receiver.map &:name
  end

  #=====================================
  # Content#method_missing
  #=====================================
  def method_missing name, *args
    #===================================
    # Content#***_names
    #   Content#namesの呼出
    #===================================
    return self.names "#{$1}s".to_sym if name =~ /^(.+?)s?_names$/
    # 上層呼出
    super
  end
end
