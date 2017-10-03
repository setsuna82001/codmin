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

  #=======================================
  # Author::child_name
  #=======================================
  it '::child_name' do
    expect(Author::child_name).to eq :Author
  end

  #=======================================
  # Author::child_class
  #=======================================
  it '::child_class' do
    expect(Author::child_class).to eq Author
  end
end
