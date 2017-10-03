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

  #=======================================
  # Tag::child_name
  #=======================================
  it '::child_name' do
    expect(Tag::child_name).to eq :Tag
  end

  #=======================================
  # Tag::child_class
  #=======================================
  it '::child_class' do
    expect(Tag::child_class).to eq Tag
  end
end
