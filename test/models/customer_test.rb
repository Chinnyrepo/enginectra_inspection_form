require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @customer = Customer.new(email: "luvchiny@yahoo.com",
                            password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @customer.valid?
  end

  test "email should be present" do
    @customer.email = " "
    assert_not @customer.valid?
  end

  test "email should not be long" do
    @customer.email = "a" * 245 + "@example.com
    asser_not @customer.valid?
  end

  test "email should accept correct format" do
    valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @customer.email = valids
      assert @customer.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "should reject invalid addresses" do
    invalid_emails = %w[mashrur@example mashrur@example,com mashrur.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @customer.email = invalids
      assert_not @customer.valid?, "#{invalids.inspect} should be invalid"
    end
  end 
    
  test "email should be unique and case insensitive" do
    duplicate_customer = @customer.dup
    duplicate_customer.email = @customer.email.upcase
    @customer.save
    assert_not duplicate_customer.valid?
  end

  test "password should be present" do
    @customer.password = @customer.password_confirmation = " "
    assert_not @customer.valid?
  end
  
  test "password should be atleast 5 character" do
    @customer.password = @customer.password_confirmation = "x" * 4
    assert_not @customer.valid?
  end
end
