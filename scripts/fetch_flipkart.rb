require 'pp'

flipkart_orders = Order.fetch_from_flipkart(start_date=5.months.ago, end_date=Time.now, status='pending')
flipkart_orders += Order.fetch_from_flipkart(start_date=5.months.ago, end_date=Time.now, status='approved')
flipkart_orders += Order.fetch_from_flipkart(start_date=5.months.ago, end_date=Time.now, status='cancelled')

orders_with_tracking = flipkart_orders.select {|order| order.aff_ext_param1.to_s != ''}

orders_with_tracking.count

orders_with_tracking.each do |order|
  tracking = Tracking.find_by_id(order.aff_ext_param1)
  if tracking and tracking.order
    puts "Tracked Order: " + tracking.id.to_s + " Status:" + order.status
  elsif tracking
    puts "Untracked Order: " + tracking.id.to_s + " Status:" + order.status
    pp order.marshal_dump
  end
end

