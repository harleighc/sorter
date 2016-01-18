class Item < ActiveRecord::Base
before_save :update_status
before_save :update_status2
before_save :lowercase
validates_presence_of :category



  def self.import(file)
    x = File.open(file.path)
    y = CSV.parse(x, headers: true)
    y.each do |row|
    z = row.to_hash
    z[:identifier] = "UPLOAD7"
      Item.create! z
    end
  end

 private

## updates the status to indicate this is a category chosen by user - at present if you
## import 2 csv's this is consided an update and all status's changed. Should also change back ## if added to the unsorted category.

  def update_status
    self.status = 0 if category_changed?
  end
  def update_status2
    self.status = 4 if category == "UNSORTED PURCHASE"
  end
def lowercase
    self[:item].titleize
end
end
