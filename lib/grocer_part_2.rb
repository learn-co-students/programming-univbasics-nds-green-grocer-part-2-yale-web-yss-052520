require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupon_array = []
  
  coupons.each do |coupon|
    if find_item_by_name_in_collection(coupon[:item], cart)
      item = find_item_by_name_in_collection(coupon[:item], cart)
      
      if item[:count] >= coupon[:num]
        new_count = item[:count] % coupon[:num]
    
        discounted_item = {}
        discounted_item[:item] = item[:item] + " W/COUPON"
        discounted_item[:price] = coupon[:cost] / coupon[:num]
        discounted_item[:clearance] = item[:clearance]
        discounted_item[:count] = item[:count] - new_count
      
        cart.each do |hash|
          if hash[:item] == coupon[:item]
            hash[:count] = new_count
          end
        end
        
        coupon_array.push(discounted_item)
      end
    end
  end
  
  cart.concat(coupon_array)
end

def apply_clearance(cart)
  cart.each do |hash|
    if hash[:clearance]
      hash[:price] *= 0.8
      hash[:price].round(2)
    end
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  
  total = cart.reduce(0) { |total, hash| total + (hash[:price] * hash[:count]) }
  
  
  if total > 100
    total *= 0.9
  end
  
  total.round(2)
end