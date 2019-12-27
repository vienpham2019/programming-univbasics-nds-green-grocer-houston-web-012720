require "pry"
def find_item_by_name_in_collection(name, collection)

  # Implement me first!
  #
  # Consult README for inputs and outputs
  answer = nil
  collection.each do |e|
    if e[:item] == name 
      answer = e 
    end
  end
  answer
end

def consolidate_cart(cart)
  
    # Consult README for inputs and outputs
    #
    # REMEMBER: This returns a new Array that represents the cart. Don't merely
    # change `cart` (i.e. mutate) it. It's easier to return a new thing.
    
  count = Hash.new(0)
  new_array = cart.uniq
  cart.each do |e|
    count[e[:item]] += 1
  end
  new_array.each do |e|
    count.to_a.each do |n|
      if e[:item] == n[0]
        e[:count] = n[1]
      end
    end
  end
  new_array
end

def apply_coupons(cart, coupons)
  
    # Consult README for inputs and outputs
    #
    # REMEMBER: This method **should** update cart
    
  cart.each do |food|
    coupons.each do |coupon|
      if food[:item] == coupon[:item] && food[:count] >= coupon[:num]
          new_hash = food.clone
          new_hash[:item] = "#{new_hash[:item]} W/COUPON"
          new_hash[:price] = coupon[:cost].to_f / coupon[:num]
          if food[:item] == "BEER"
            new_hash[:count] = coupon[:num]
            food[:count] = food[:count] - coupon[:num]
          else
            new_hash[:count] = food[:count] - food[:count] % coupon[:num]
            food[:count] = food[:count] % coupon[:num]
          end
          cart.insert(cart.index(food) + 1,new_hash)
      end
    end
  end
  cart
end

def apply_clearance(cart)

    # Consult README for inputs and outputs
    #
    # REMEMBER: This method **should** update cart
    
  cart.each do |food|
    if food[:clearance]
      food[:price] = food[:price] * 0.8
    end
  end
  cart
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
      
  my_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(my_cart,coupons)
  after_coupon_and_clearance = apply_clearance(cart_with_coupons)
  total = 0
  after_coupon_and_clearance.each do |grocery|
    total += (grocery[:count].to_f * grocery[:price].round(3))
  end
  if total > 100
    total *= 0.9
  end
  total
end












