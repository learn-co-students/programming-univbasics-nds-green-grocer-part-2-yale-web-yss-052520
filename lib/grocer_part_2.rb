require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each_with_object([]) do |object, coupon_cart|
    coupon = find_item_by_name_in_collection(object[:item], coupons)
    if coupon && object[:count] >= coupon[:num]
      # binding.pry
      new_item = {
        item: object[:item] + " W/COUPON",
        count: coupon[:num],
        price: (coupon[:cost] / coupon[:num]).round(2),
        clearance: object[:clearance]
      }
      coupon_cart << new_item
      object[:count] -= coupon[:num]
    
    end
    coupon_cart.push object
  end
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.map do |item|
    # binding.pry
    if item[:clearance]
      item[:price] *= 0.8
      item[:price].round(2)
    end
    item
   # binding.pry
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated_cart = consolidate_cart(cart)
  # binding.pry
  
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  # binding.pry
  
  final_cart = apply_clearance(coupon_cart)
  # binding.pry
  sum = 0
  final_cart.each do |item|
    sum += item[:price].round(2) * item[:count]
  end
  # binding.pry
  if sum > 100
    sum *= 0.9
  end
  sum
end
