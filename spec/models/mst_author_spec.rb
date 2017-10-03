require 'rails_helper'

RSpec.describe MstAuthor, type: :model do
  #=======================================
  # MstAuthor::master_name
  #=======================================
  it '::master_name' do
    expect(MstAuthor::master_name).to eq :MstAuthor
  end

  #=======================================
  # MstAuthor::master_class
  #=======================================
  it '::master_class' do
    expect(MstAuthor::master_class).to eq MstAuthor
  end

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

  #=======================================
  describe do
    let(:content){ FactoryGirl::create :content }
    let(:author){ content.mst_authors.first }

    #=====================================
    # MstAuthor#children
    #=====================================
    it '.children' do
      expect(author.children).to all an_instance_of(Author)
    end

    #=====================================
    # MstAuthor#content_ids
    #=====================================
    it '.content_ids' do
      expect(author.content_ids).to eq [1]
    end

  end
end
