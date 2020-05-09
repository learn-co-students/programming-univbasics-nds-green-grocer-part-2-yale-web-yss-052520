require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  coupons.each do |coupon| 
    item_info = find_item_by_name_in_collection(coupon[:item], cart)
    next if (not item_info) || coupon[:num] > item_info[:count]
    item_info[:count] -= coupon[:num]
    
    new_item = {
      item: item_info[:item] + " W/COUPON",
      price: coupon[:cost]/coupon[:num],
      clearance: item_info[:clearance],
      count: coupon[:num]
    }
    cart.push(new_item)
  end 
  cart
end

def apply_clearance(cart)
  for item in cart do
    item[:price] = (item[:price]*0.8) if item[:clearance]
  end 
end

def checkout(cart, coupons)
  org_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(org_cart, coupons)
  apply_clearance(coupon_cart)
  
  total = coupon_cart.reduce(0) {|total, item| total += item[:count] * item[:price]}
  total *= 0.9 if total > 100
  return total.round(2)
end
