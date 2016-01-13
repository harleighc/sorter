class Item < ActiveRecord::Base
before_save :update_status

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

end
