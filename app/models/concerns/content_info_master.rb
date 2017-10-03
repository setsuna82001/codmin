module ContentInfoMaster
  extend ActiveSupport::Concern
  
  #=====================================
  # ContentInfoMaster#children
  #   サブテーブルのインスタンスを返す
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
