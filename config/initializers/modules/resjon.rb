module Resjon
  DEFAULT_JSON_BASE  = {
    status:   200,
    message:  ''
  }

  ERROR_STATUS_TABLE = {
    400 => '不正なリクエストです',
    404 => '対象のデータが見つかりませんでした',
    409 => '登録済みのデータです',
    500 => 'システムエラーが発生しました'
  }

  #=====================================
  # ClassMethods
  #=====================================
  class << self
    #===================================
    # Resjon::errorXXX
    #   => ERROR_STATUS_TABLE を参照して, エラーコードとメッセージをjsonで生成
    #===================================
    def method_missing name, *args
      if Datamaker::respond_to? name
        Datamaker::send(name, *args).to_json
      elsif name =~ /^error(\d{3})$/
        Datamaker::send(name, *args).to_json
      else
        super
      end
    end
  end

  #=====================================
  # Resjon::Message
  #=====================================
  module Message
    #===================================
    # ClassMethods
    #===================================
    class << self
      #===================================
      # Resjon::Message::errorXXX
      #   => ERROR_STATUS_TABLE を参照して, エラーメッセージを生成
      #===================================
      def method_missing name, *args
        if name =~ /^error(\d{3})$/
          code  = $1.to_i
          return Resjon::ERROR_STATUS_TABLE[code]
        else
          super
        end
      end

    end
  end

  #=====================================
  # Resjon::Datamaker
  #=====================================
  module Datamaker
    #===================================
    # ClassMethods
    #===================================
    class << self
      #=================================
      # Resjon::Datamaker::normal
      #   => 正常終了のデータを生成
      #=================================
      def normal data = nil
        if data.nil?
          return Resjon::DEFAULT_JSON_BASE
        else
          return Resjon::DEFAULT_JSON_BASE.regist :results, data
        end
      end

      #=================================
      # Resjon::Datamaker::error
      #   => エラーコード と メッセージを生成
      #=================================
      def error code, mess, opt = {}
        response = {
          status:   code,
          message:  mess
        }
        response.merge! opt if Hash === opt
        return response
      end

      #===================================
      # Resjon::Datamaker::errorXXX
      #   => ERROR_Datamake を参照して, エラーコードとメッセージのデータを生成
      #===================================
      def method_missing name, *args
        if name =~ /^error(\d{3})$/
          code    = $1.to_i
          message = Resjon::Message::send name, *args
          error code, message, *args
        else
          super
        end
      end

    end
  end
end
