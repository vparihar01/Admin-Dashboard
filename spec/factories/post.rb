Factory.define :post do |f|
  f.title "test"
  f.content "test statement"
end

Factory.define :invalid_post, :parent => :post do |f|
  f.title ""
  f.content ""
end