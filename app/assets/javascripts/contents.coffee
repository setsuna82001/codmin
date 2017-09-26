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
  # create
  #   DMMコンテンツ検索
  #=========================================
  $scope.create = (data)->
    # TODO curtain
    $.post '/contents', data, (resp)->
      c resp

  #=========================================
  # dmmsearch
  #   DMMコンテンツ検索
  #=========================================
  $scope.dmmsearch = (str)->
    # 空文字チェック
    return unless str
    # TODO curtain
    $.post '/api/search', {searchstr: str}, (data)->
      $scope.$apply ->
        $scope.searchlist = data
