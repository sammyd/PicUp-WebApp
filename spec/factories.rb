Factory.define :photo do |photo|
  photo.image             File.new(Rails.root.join("spec/fixtures/sample.jpg"))
  photo.browserDetails    "Some sample browser details"
  photo.fromIP            "127.0.0.1"
end

Factory.sequence :browser do |n|
  "Browser-#{n}"
end

Factory.sequence :ip do |n|
  "192.168.0.#{n}"
end