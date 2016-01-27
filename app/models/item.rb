class Item < ActiveRecord::Base
before_save :update_status
before_save :update_status2
#validates_presence_of :category


def self.import(file)
x = CSV.read(file.path)

x = x.drop(7)


x.each do |row|
 case row[2]
  when "A/P"
    row[1] = row[4]
    row[2] = "regular payment"
  when "D/D"
    row[1] = row[4]
    row[2] = "regular payment"
  when "BANK FEE"
    row[1] = row[4]
    row[2] = "bank fees"
  when "INT"
    row[1] = row[4]
    row[2] = "interest"
  when "WD"
    row[1] = row[4]
    row[2] = "bank fees"
  when "EFTPOS"
    row[1] = row[4]
    row[2] = "unsorted"
  when "ATM"
    row[1] = row[4]
    row[2] = "cash out"
  when "DEBIT"
    row[1] = row[5]
    row[2] = "unsorted"
  when "TFR IN"
    row[1] = row[5]
    row[2] = "transfer"
  when "D/C"
    row[1] = row[5]
    row[2] = "income"
  when "CREDIT"
    row[1] = row[5]
    row[2] = "income"
  when "TRF OUT"
    row[1] = row[5]
    row[2] = "transfer"
  else
    row[1] = row[5]
    row[2] = "unsorted"


  	end
  end

x.each do |row|
		row << 3
		row << 0.1304
		row << 1
  row << 88
end

csv = []


ord = [1,6,2,7,8,9,0,10]
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

end
