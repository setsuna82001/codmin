angular
.module('contentsApp', [])
.controller 'ngCtrl', ($scope) ->
  #=========================================
  # init
  #   初期化
  #=========================================
  $scope.init = ->
    $scope.searchlist = []

  #=========================================
  # dmmsearch
  #   DMMコンテンツ検索
  #=========================================
  $scope.dmmsearch = (str)->
    # 空文字チェック
    return unless str
    $.post '/api/search', {searchstr: str}, (data)->
      $scope.$apply ->
        $scope.searchlist = data
