FactoryGirl.define do
  factory :mst_author do
    sequence :name do |n|
      "作者#{n}"
    end
  end
end
