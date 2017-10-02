describe 'contents', type: :routing do
  before do
    # 異常系のコールバック試験を定義
    @callback = lambda{|method, path|
      expect(method => path).to route_to(
        controller: 'error',
        action:     'error_404',
        path:       path.sub(/^\//, '')
      )
    }
  end

  it 'routes /info' do
    # 正常系
    expect(get: '/info').to route_to(controller: 'info', action: 'index')
  end
end
