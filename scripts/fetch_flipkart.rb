require 'pp'

orders = Order.fetch_from_flipkart(start_date=5.months.ago, end_date=Time.now, status='pending')
orders += Order.fetch_from_flipkart(start_date=5.months.ago, end_date=Time.now, status='approved')
orders += Order.fetch_from_flipkart(start_date=5.months.ago, end_date=Time.now, status='cancelled')

orders = orders.select {|order| order.aff_ext_param1.to_s != ''}

orders = orders.group_by { |order| order.aff_ext_param1 }

orders.keys.sort.each do |tracking_id|
  tracking = Tracking.find_by_id(tracking_id)
  puts "=========================================\n\n"
  if tracking and tracking.order
    message = "Tracked Order: #{tracking.id} ==========="
    puts message.green
    puts "Order amount: #{tracking.order.amount}"
    puts "Order status: #{tracking.order.statustext} \n\n"
  elsif tracking
    message = "Untracked Order: #{tracking.id} =========== \n"
    puts message.red
    unless tracking.user
      puts 'No user attached'.yellow
    end
  else
    puts "Tracking #{tracking_id} not found\n\n"
  end

  flipkart_orders = orders[tracking_id]

  puts "#{flipkart_orders.count} Flipkart Items found"

  totals = {
    tentative: flipkart_orders.select { |order| order.status == 'tentative'}.sum { |a| a.sales['amount'] },
    processed: flipkart_orders.select { |order| order.status == 'processed'}.sum { |a| a.sales['amount'] },
    failed:    flipkart_orders.select { |order| order.status == 'failed'}.sum { |a| a.sales['amount'] }
  }

  puts "Processed: #{totals[:processed]}".green
  puts "Tentative: #{totals[:tentative]}".yellow
  puts "Failed: #{totals[:failed]}".red
  puts "\n"
end

# orders.keys.sort.each do |tracking_id|
#   puts "Tracking ID: #{key} =============="
#   tracking = Tracking.find_by_id(tracking_id)
#   orders[tracking_id].each do |order|
#     if tracking and tracking.order
#       message = "Tracked Order: " + tracking.id.to_s + "\n"
#     if tracking.order.status == 1 and order.status == 'tentative'
#       message += 'Status:' + order.status
#       puts message.green
#     elsif tracking.order.status == 2 and order.status == 'processed'
#       message += 'Status:' + order.status
#       puts message.green
#     elsif tracking.order.status == 3 and order.status == 'failed'
#       message += 'Status:' + order.status
#       puts message.green
#     else
#       message += 'Flipkart Status: ' + order.status + "\n"
#       message += 'Rechaargery Status: ' + tracking.order.statustext + "\n"
#       puts message.red
#     end
#   elsif tracking
#     message = "Untracked Order: " + tracking.id.to_s + " Status:" + order.status
#     puts message.yellow
#     if tracking.user
#       pp order.marshal_dump
#     else
#       puts 'No user attached'.yellow
#     end
#   end
# end

# orders_with_tracking.each do |order|
#   tracking = Tracking.find_by_id(order.aff_ext_param1)
#   if tracking and tracking.order
#     message = "Tracked Order: " + tracking.id.to_s + "\n"
#     if tracking.order.status == 1 and order.status == 'tentative'
#       message += 'Status:' + order.status
#       puts message.green
#     elsif tracking.order.status == 2 and order.status == 'processed'
#       message += 'Status:' + order.status
#       puts message.green
#     elsif tracking.order.status == 3 and order.status == 'failed'
#       message += 'Status:' + order.status
#       puts message.green
#     else
#       message += 'Flipkart Status: ' + order.status + "\n"
#       message += 'Rechaargery Status: ' + tracking.order.statustext + "\n"
#       puts message.red
#     end
#   elsif tracking
#     message = "Untracked Order: " + tracking.id.to_s + " Status:" + order.status
#     puts message.yellow
#     if tracking.user
#       pp order.marshal_dump
#     else
#       puts 'No user attached'.yellow
#     end
#   end
# end




