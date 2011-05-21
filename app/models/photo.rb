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
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  
  attr_accessible :browserDetails, :fromIP, :image
  has_attached_file :image
  
  validates :fromIP, 
            :presence => true, 
            :format => { :with => @ip_regex }
  validates :browserDetails, :presence => true
  
  validates_attachment_presence :image

            
end
