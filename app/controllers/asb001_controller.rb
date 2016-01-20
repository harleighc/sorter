def self.import(file)
x = CSV.read(file.path)
x = x.drop(7)
x.each do |row|


  	row[1] = row[4] if row[2] == "A/P"
  	row[2] = "regular payment" if row[2] == "A/P"
  row[1] = row[4] if row[2] == "D/D"
  	row[2] = "regular payment" if row[2] == "D/D"
  row[1] = row[4] if row[2] == "BANK FEE"
    row[2] = "bank fees" if row[2] == "BANK FEE"
  row[1] = row[4] if row[2] == "INT"
    row[2] = "interest" if row[2] == "INT"
  row[1] = row[4] if row[2] == "WD"
    row[2] = "bank fees" if row[2] == "WD"
  row[1] = row[4] if row[2] == "EFTPOS"
    row[2] = "unsorted purchase" if row[2] == "EFTPOS"
  row[1] = row[4] if row[2] == "ATM"
  row[2] = "cash out" if row[2] == "ATM"


  row[1] = row[5] if row[2] == "DEBIT"
  	row[2] = "unsorted purchase" if row[2] == "DEBIT"
	row[1] = row[5] if row[2] == "TFR IN"
    row[2] = "transfer" if row[2] == "TFR IN"
	row[1] = row[5] if row[2] == "D/C"
    row[2] = "income" if row[2] == "D/C"
   	row[1] = row[5] if row[2] == "CREDIT"
    row[2] = "income" if row[2] == "CREDIT"
 	row[1] = row[5] if row[2] == "TFR OUT"
    row[2] = "transfer" if row[2] == "TFR OUT"

  	end



x.each do |row|
		row << 3
		row << 0.15
		row << 1
		row << 11
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