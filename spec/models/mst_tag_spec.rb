require 'rails_helper'

RSpec.describe MstTag, type: :model do
  #=======================================
  # MstTag::child_name
  #=======================================
  it '::child_name' do
    expect(MstTag::child_name).to eq :Tag
  end

  #=======================================
  # MstTag::child_class
  #=======================================
  it '::child_class' do
    expect(MstTag::child_class).to eq Tag
  end
end
