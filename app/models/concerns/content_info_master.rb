module ContentInfoMaster
  extend ActiveSupport::Concern

  #=====================================
  # include 俺
  #=====================================
  included do |klass|
    # included 時に ClassMethods を定義
    klass.extend ClassMethods
    # Settingsの情報を保持
    name = klass.name.downcase[3..-1]
    klass::const_set :RELATIONS, Settings.dig(*%I(relations #{name}))
  end

  #=====================================
  # ClassMethods
  #=====================================
  class_methods do
    #===================================
    # ContentInfoMaster::child_name
    #   サブテーブルのクラス名を返す
    #===================================
    def child_name
      self::RELATIONS.dig *%i(model child)
    end
    #===================================
    # ContentInfoMaster::child_class
    #   サブテーブルのクラスを返す
    #===================================
    def child_class
      Kernel::const_get child_name
    end
  end

  #=====================================
  # ContentInfoMaster#children
  #   サブテーブルを返す
  #=====================================
  def children
    send self.class::RELATIONS.dig *%i(relation child)
  end

  #=====================================
  # ContentInfoMaster#children
  #   関連するコンテンツIDのリストを返す
  #=====================================
  def content_ids
    children.map &:content_id
  end
end
