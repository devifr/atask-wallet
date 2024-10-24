FactoryBot.define do
  factory :wallet do
    balance { 100.0 }

    trait :for_user do
      walletable { association :user }
    end

    trait :for_team do
      walletable { association :team } 
    end

    trait :for_stock do
      walletable { association :stock } 
    end
  end
end
