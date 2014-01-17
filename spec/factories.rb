FactoryGirl.define do
  factory :user do     # Here we are passing the symbol ':user' to the factory command, which tells Factory Girl that the 
                       # following definintion defines a User model object
    name      "Michael Hartl"
    email     "michael@example.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end