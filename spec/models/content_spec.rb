require 'rails_helper'

RSpec.describe Content, type: :model do
  let(:content){
    FactoryGirl::create :content
  }

  %i(authors tags).each{|type|
    #=======================================
    # Content#***s
    # Content#mst_***s
    #=======================================
    it "content has #{type} method" do
      expect(content).to respond_to type
      expect(content.send type).to all
    end

    it "content has #{type} methods" do
      expect(content).to respond_to type
      expect(content).to respond_to "mst_#{type}".to_sym
    end

  }
end
