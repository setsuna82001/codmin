describe Resjon do
  #=======================================
  # Resjon::Message::errorXXX
  #=======================================
  it "::Message errors" do
    Resjon::ERROR_STATUS_TABLE.each{|code, msg|
      expect(Resjon::Message::send "error#{code}").to eq msg
    }
  end

  #=======================================
  # Resjon::Datamaker::errorXXX
  #=======================================
  it "::Datamaker errors" do
    Resjon::ERROR_STATUS_TABLE.each{|code, msg|
      expect(Resjon::Datamaker::send "error#{code}").to eq({
        status:   code,
        message:  msg
      })
    }
  end

  #=======================================
  # Resjon::Datamaker::normal
  #=======================================
  it "::normal" do
    expect(Resjon::Datamaker::normal).to eq({
      status:   200,
      message:  ''
    })
  end

  #=======================================
  # Resjon::Datamaker::normal
  #=======================================
  it "::normal args" do
    [[], {}, '', 0].each{|arg|
      expect(Resjon::Datamaker::normal arg).to eq({
        status:   200,
        message:  '',
        results:  arg
      })
    }
  end

  #=======================================
  # Resjon::errorXXX
  #=======================================
  it "::errorXXX" do
    Resjon::ERROR_STATUS_TABLE.each{|code, msg|
      json = Resjon::send "error#{code}"
      expect(JSON::parse json, symbolize_names: true).to eq({
        status:   code,
        message:  msg
      })
    }
  end

  #=======================================
  # Resjon::Datamaker::normal
  #=======================================
  it "::normal" do
    json = Resjon::normal
    expect(JSON::parse json, symbolize_names: true).to eq({
      status:   200,
      message:  ''
    })
  end

  #=======================================
  # Resjon::Datamaker::normal
  #=======================================
  it "::normal args" do
    [[], {}, '', 0].each{|arg|
      json = Resjon::normal arg
      expect(JSON::parse json, symbolize_names: true).to eq({
        status:   200,
        message:  '',
        results:  arg
      })
    }
  end
end
