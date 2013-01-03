Factory.define :role do |f|
  f.name "staff"
end

Factory.define :admin, :parent => :role  do |f|
  f.name "admin"
end

Factory.define :registered, :parent => :role  do |f|
  f.name "registered"
end