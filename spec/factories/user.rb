Factory.define :user do |f|
  f.email "test@yopmail.com"
  f.password "123456"
  f.password_confirmation "123456"
end

Factory.define :staff, :parent => :user do |f|
  f.email "test1@yopmail.com"
  f.password "123456"
  f.password_confirmation "123456"
end