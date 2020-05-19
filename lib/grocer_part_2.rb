require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = cart.each do |item|
    coupons.each do |coupon|
      if item[:item] == coupon[:item]
        if item[:count] >= coupon[:num]
          new_price = coupon[:cost] / coupon[:num]
          #new_count = item[:count] - coupon[:count]
          #if new_count > 0 
          item[:count] = item[:count] - coupon[:num] 
          #else
          #  item.delete 
          #end
          cart << {
            :item => "#{item[:item]} W/COUPON",
            :price => new_price,
            :clearance => item[:clearance],
            :count => coupon[:num]
          }
        end
      end
    end
    #clean_new_cart = new_cart.flatten
    #consolidate_cart(clean_new_cart)
    #binding.pry 
  end
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = cart.each do |item|
    if item[:clearance] == true
      new_price = item[:price] * 0.8
      item[:price] = new_price.round(2)
    end
  end
  new_cart
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
  consolidated = consolidate_cart(cart)
  couponed = apply_coupons(consolidated, coupons)
  clearanced = apply_clearance(couponed)
  totaled = clearanced.reduce(0) do |total, item|
    item_cost = item[:price] * item[:count]
    total = total + item_cost
    total 
  end
  if totaled > 100
    totaled = totaled * 0.9
  end
  totaled
end
