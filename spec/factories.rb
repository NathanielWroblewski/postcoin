FactoryGirl.define do
  sequence :email do |n|
    "cc#{n}@postco.in"
  end

  sequence :password do |n|
    "password#{n}"
  end

  factory :address do
    user
  end

  factory :user do
    email    { generate(:email) }
    password { generate(:password) }
  end

  factory :email, class: OpenStruct do
    # Assumes Griddler.configure.to is :hash (default)
    to [{ raw: 'to_user@email.com', email: 'to_user@email.com', token: 'to_user', host: 'email.com' }]
    from 'user@email.com'
    subject 'email subject'
    body 'Hello!'
    attachments {[]}

    trait :with_attachment do
      attachments {[
        ActionDispatch::Http::UploadedFile.new({
          filename: 'img.png',
          type: 'image/png',
          tempfile: File.new("#{File.expand_path File.dirname(__FILE__)}/fixtures/img.png")
        })
      ]}
    end
  end
end
