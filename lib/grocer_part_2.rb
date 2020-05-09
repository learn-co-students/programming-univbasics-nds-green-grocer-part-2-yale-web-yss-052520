require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  coupons.each do |coupon| 
    item_info = find_item_by_name_in_collection(coupon[:item], cart)
    next if (not item_info) || coupon[:num] > item_info[:count]
    item_info[:count] -= coupon[:num]
    
    new_item = {}
    new_item[:item] = item_info[:item] + " W/COUPON"
    new_item[:price] = coupon[:cost]/coupon[:num]
    new_item[:clearance] = item_info[:clearance]
    new_item[:count] = coupon[:num]
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
  
  total = 0
  for item in coupon_cart do
    total += item[:count] * item[:price]
  end 
  
  total *= 0.9 if total > 100
  return total.round(2)
end
