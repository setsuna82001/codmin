require 'rails_helper'

RSpec.describe MstTag, type: :model do
  #=======================================
  # MstTag::master_name
  #=======================================
  it '::master_name' do
    expect(MstTag::master_name).to eq :MstTag
  end

  #=======================================
  # MstTag::master_class
  #=======================================
  it '::master_class' do
    expect(MstTag::master_class).to eq MstTag
  end

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

  #=======================================
  describe do
    let(:content){ FactoryGirl::create :content }
    let(:tag){ content.mst_tags.first }

    #=====================================
    # MstTag#children
    #=====================================
    it '.children' do
      expect(tag.children).to all an_instance_of(Tag)
    end

    #=====================================
    # MstTag#content_ids
    #=====================================
    it '.content_ids' do
      expect(tag.content_ids).to eq [1]
    end

  end
end
