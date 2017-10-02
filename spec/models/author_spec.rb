require 'rails_helper'

RSpec.describe Author, type: :model do
  #=======================================
  # Author::master_name
  #=======================================
  it '::master_name' do
    expect(Author::master_name).to eq :MstAuthor
  end

  #=======================================
  # Author::master_class
  #=======================================
  it '::master_class' do
    expect(Author::master_class).to eq MstAuthor
  end
end
