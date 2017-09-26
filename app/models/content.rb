class Content < ApplicationRecord
  # tag side
  has_many :tags, dependent: :destroy
  has_many :mst_tags, through: :tags

  # author side
  has_many :authors, dependent: :destroy
  has_many :mst_authors, through: :authors

  class << self
    #===================================
    # Content::master_class
    #   Master*** のクラスを返す
    #===================================
    def master_class type
      text  = type.to_s.singularize
      caml  = text.camelize
      name  = "Mst#{caml}".to_sym
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
        %i(tags authors).each{|type|
          record.regist_subtable type, data[type]
        }

        # return record data
        record
      end
    end
  end

  #=====================================
  # Content#master
  #   mst_***s を返す
  #=====================================
  def master type
    # make receiver
    symbol    = "mst_#{type}".to_sym
    receiver  = self.send symbol
  end

  #=====================================
  # Content#regist_subtable
  #   サブテーブルのレコード登録
  #=====================================
  def regist_subtable type, list
    # make receiver
    receiver  = self.master type
    # make master class
    klass     = self.class::master_class type
    # regist each data
    list.each{|text|
      # record.mst_tags << MstTag::find_or_create_by
      receiver << klass::find_or_create_by(name: text)
    }
  end
end
