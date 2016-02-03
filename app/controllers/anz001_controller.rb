
class Item < ActiveRecord::Base


def self.import(file)
x = CSV.read(file.path)

x.each do |row|
 case row[0]
  when "Eft-Pos"
   row[0] = "unsorted"
when "Atm Debit"
   row[0] = "cash out"
when "Automatic Payment"
   row[0] = "regular payment"
when "Other Bank ATM Fee"
   row[1] = "other bank atm fee"
   row[0] = "bank fees"
when "Direct Debit"
   row[0] = "regular payment"
when "Debit Transfer"
   row[1] = "debit transfer"
   row[0] = "transfer"
when "Direct Credit"
   row[0] = "income"
when "Payment"
   row[0] = "unsorted"
when "Bill Payment"
   row[0] = "income"
when "Credit Transfer"
   row[0] = "transfer"
when "Eft-Pos Credit"
   row[0] = "unsorted"
when "Bank Fee"
   row[0] = "bank fees"
when "Debit Interest"
   row[1] = "debit interest"
   row[0] = "interest"
when "Overseas ATM Fee"
   row[1] = "overseas atm fee"
   row[0] = "bank fees"
when "One-Off Payment"
   row[0] = "unsorted"
when "Unpaid Item"
   row[0] = "unsorted"
when "Deposit"
   row[0] = "income"
 else
   row[0] = "unsorted"
    end
  end

  x.each do |row|
    case row[1]
      when nil
      row[1] = "no information provided"
    end
  end

x.each do |row|
  row.unshift(88)
  row.unshift(1)
  row.unshift(0.1304)
    row.unshift(3)


end


csv = []
ord = [5,9,4,0,1,2,10,3]
x.each do |row|
   csv << row.values_at(*ord)



end
csv.each do |row|
  Item.create(:item => row[0],:value => row[1],:category => row[2],:status => row[3],:gst => row[4],:multiplier => row[5],:date => row[6], :identifier => row[7])

    end

end


 private

## updates the status to indicate this is a category chosen by user - at present if you
## import 2 csv's this is consided an update and all status's changed. Should also change back ## if added to the unsorted cat.


end
