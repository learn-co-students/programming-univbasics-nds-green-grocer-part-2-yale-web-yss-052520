require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart_of_discounted_items=[]
   coupons.each {|coupon|
     if find_item_by_name_in_collection(coupon[:item], cart)
       cart.each { |item_in_cart|
         if item_in_cart[:item]==coupon[:item] && item_in_cart[:count]>=coupon[:num]
           item_in_cart[:count]=item_in_cart[:count]-coupon[:num]
           discounted_item={
             :item => "#{item_in_cart[:item]} W/COUPON",
             :price => coupon[:cost]/coupon[:num],
             :count => coupon[:num],
             :clearance => item_in_cart[:clearance]
           }
           cart_of_discounted_items << discounted_item
           #if item_in_cart[:count]<=0
            # cart.delete(item_in_cart)
           #end
         end
       }
     end
   }
   #binding.pry
   cart=cart.compact+cart_of_discounted_items
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.collect {|item|
    item[:clearance] ? item.merge!({:price => (item[:price]*0.80).round(2)}) : item
  }
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
  cart=apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  tally=cart.reduce(0.00){ |total, item|
    total+=item[:price]*item[:count]
  }
  #binding.pry
  p tally
  p coupons
  p tally>100 ? tally*0.9 : tally
end
