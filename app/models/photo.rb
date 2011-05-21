# == Schema Information
# Schema version: 20110521114424
#
# Table name: photos
#
#  id                 :integer         not null, primary key
#  browserDetails     :string(255)
#  fromIP             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  
  attr_accessible :browserDetails, :fromIP
end
