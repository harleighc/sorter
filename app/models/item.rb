class Item < ActiveRecord::Base

  def self.import(file)
    x = File.open(file.path)
    y = CSV.parse(x, headers: true)
    y.each do |row|
    z = row.to_hash
    z[:identifier] = "UPLOAD6"
      Item.create! z
    end
  end
end
