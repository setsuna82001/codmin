require 'rails_helper'

RSpec.describe Tag, type: :model do
  #=======================================
  # Tag::master_name
  #=======================================
  it '::master_name' do
    expect(Tag::master_name).to eq :MstTag
  end

  #=======================================
  # Tag::master_class
  #=======================================
  it '::master_class' do
    expect(Tag::master_class).to eq MstTag
  end
end
