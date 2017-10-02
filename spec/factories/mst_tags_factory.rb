FactoryGirl.define do
  factory :mst_tag do
    sequence :name do |n|
      "タグ#{n}"
    end
  end
end
