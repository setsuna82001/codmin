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
      if resp.status == 200
        location.href = resp.results;
      else
        # TODO message
        alert '処理に失敗しました'

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
