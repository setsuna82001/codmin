require 'rails_helper'

RSpec.describe MstAuthor, type: :model do
  #=======================================
  # MstAuthor::child_name
  #=======================================
  it '::child_name' do
    expect(MstAuthor::child_name).to eq :Author
  end

  #=======================================
  # MstAuthor::child_class
  #=======================================
  it '::child_class' do
    expect(MstAuthor::child_class).to eq Author
  end
end
