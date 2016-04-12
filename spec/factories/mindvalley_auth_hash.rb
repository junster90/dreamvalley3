FactoryGirl.define do
  factory :mindvalley_auth_hash, class: OmniAuth::AuthHash do
    skip_create

    transient do
      sequence(:uid)
      provider "mindvalley"
      token SecureRandom.hex(10)
      id_token SecureRandom.hex(20)
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
    end

    factory :staff_hash do 
      initialize_with do 
        OmniAuth::AuthHash.new({ 
          uid: uid, 
          provider: provider,
          info: { 
            first_name: first_name,
            last_name: last_name,
            email: first_name + "@mindvalley.com"
          },
          credentials: {
            token: token,
            id_token: id_token
          }
        })
      end
    end

    factory :nonstaff_hash do 
      initialize_with do 
        OmniAuth::AuthHash.new({ 
          uid: uid, 
          provider: provider,
          info: { 
            first_name: first_name,
            last_name: last_name,
            email: first_name + "@gmail.com"
          },
          credentials: {
            token: token,
            id_token: id_token
          }
        })
      end
    end
  end
end