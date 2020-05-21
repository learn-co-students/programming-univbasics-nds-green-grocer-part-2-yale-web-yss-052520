require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupons.each do |coupon|  
    coupon_item = coupon[:item] 
    index_of_item_in_cart = cart.index(find_item_by_name_in_collection(coupon_item, cart))
    num_in_coupon = coupon[:num]
    num_in_cart = cart[index_of_item_in_cart][:count] 
    num_applicable = (num_in_cart / num_in_coupon) * num_in_coupon 
    num_left = num_in_cart % num_in_coupon
    cart[index_of_item_in_cart][:count] = num_left 
    cart << {:item => coupon_item + " W/COUPON" } 
    cart[-1][:price] = coupon[:cost].to_f / num_in_coupon.to_f 
    cart[-1][:clearance] = cart[index_of_item_in_cart][:clearance] 
    cart[-1][:count] = num_applicable
  end 
  puts cart 
  return cart 
end

cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]

coupons= [
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
]

#apply_coupons(cart,coupons)

def apply_clearance(cart)
  cart.each do |itemhash|  
    if itemhash[:clearance] == true 
      newprice = (0.8*itemhash[:price]).round(3)
      itemhash[:price] = newprice
    end 
  end 
  puts cart
  return cart 
end

carti = [
  {:item => "PEANUT BUTTER", :price => 3.00, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 4.50, :clearance => true,  :count => 1}
]

#apply_clearance(carti) 

def checkout(cart, coupons)
  cart2 = consolidate_cart(cart)
  cart3 = apply_coupons(cart2,coupons) 
  cart4 = apply_clearance(cart3) 
  sum = 0 
  cart4.each do |itemhash| 
    amount = itemhash[:count] * itemhash[:price] 
    sum += amount 
  end 
  if sum > 100 
    sum *= 0.9 
    return sum 
  else return sum
  end 
end





