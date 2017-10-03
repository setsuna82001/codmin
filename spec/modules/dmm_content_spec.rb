describe DMMContent do
  #=======================================
  # DMMContent#search
  #=======================================
  it '#search' do
    contents = DMMContent::search '艦これ'
    expect(contents).to all(include(
      title: /.+/,
      url:  %r{http://book.dmm.com/},
      img:  %r{https://pics.dmm.com/}
    ))
  end

  #=======================================
  # DMMContent#detail
  #=======================================
  it '#detail' do
    data = DMMContent::detail 'https://book.dmm.com/detail/b950bshes00487/'
    expect(data).to match(
      authors:  an_instance_of(Array),
      tags:     an_instance_of(Array)
    )
  end

  #=======================================
  # DMMContent#detail
  #=======================================
  it '#detail illegal url' do
    data = DMMContent::detail 'http://sample/'
    expect(data).to be_nil
  end
end
