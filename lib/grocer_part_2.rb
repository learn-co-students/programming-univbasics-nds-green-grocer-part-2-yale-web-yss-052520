require_relative './part_1_solution.rb'
require 'pry'

#Helper method takes in an array of hashes (cart) and a value
# corresponding to the item key and deletes the hash with the
# value of the parameter: item.
def delete_item(item, cart)
  cart.length.times do |index|
    if cart[index][:item] == item
      cart.delete_at(index)
    end
  end
  cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if find_item_by_name_in_collection(coupon[:item], cart)[:count] >= coupon[:num]
      find_item_by_name_in_collection(coupon[:item], cart)[:count] -= coupon[:num]
      cart << {
        item: coupon[:item].upcase + " W/COUPON",
        price: coupon[:cost] / coupon[:num],
        clearance: find_item_by_name_in_collection(coupon[:item], cart)[:clearance],
        count: coupon[:num]
    }
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(3)
    end
  end
  cart
end

def checkout(cart, coupons)
  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  grand_total = 0.0
  final_cart.each do |item|
    grand_total += item[:count] * item[:price]
  end
  grand_total > 100 ? grand_total * 0.9 : grand_total
end
