class Item < ActiveRecord::Base
before_save :update_status
before_save :update_status2
before_save :lowercase
validates_presence_of :category


def self.import(file)
x = CSV.read(file.path)
x = x.drop(1)
x.each do |row|
	row.delete_at(1)
	row.delete_at(2)
	row.collect! { |element| (element == "BF") ? "bank fees" : element }

end
x.each do |row|
		row << 3
		row << 0.15
		row << 1
		row << 11
end
csv = []
ord = [0,1,3,4,5,6,2,7]
x.each do |row|
	 csv << row.values_at(*ord)
end

csv.each do |row|
  Item.create(:item => row[0],:value => row[1],:category => row[2],:status => row[3],:gst => row[4],:multiplier => row[5],:date => row[6], :identifier => row[7])

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
