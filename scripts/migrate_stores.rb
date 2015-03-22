flipkart = Store.where(:name => "Flipkart")
amazon = Store.where(:name => "Amazon")
myntra = Store.where(:name => "Myntra")
puts "Searching for Stores..."
raise "Can't find Flipkart" if flipkart.empty?
raise "Can't find Amazon" if amazon.empty?
raise "Can't find Myntra" if myntra.empty?

flipkart = flipkart.first
amazon = amazon.first
myntra = myntra.first
puts "All Stores present."

puts "Now Finding Orders..."
Order.all.each do |order|
	if order.store
		next
	end
	if order.shopname == 1 # Amazon
		order.update_columns(store_id: amazon.id)
		puts "Updated Amazon order"
	elsif order.shopname == 2 # Flipkart
		order.update_columns(store_id: flipkart.id)
		puts "Updated Flipkart order"
	elsif order.shopname == 3 # Myntra
		order.update_columns(store_id: myntra.id)
		puts "Updated Myntra order"
	end
end

