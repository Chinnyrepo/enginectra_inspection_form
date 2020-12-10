require 'test_helper'

class EngineerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @engineer = Engineer.new(email: "engineer@test.org",
                            password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @engineer.valid?
  end

  test "email should be present" do
    @engineer.email = " "
    assert_not @engineer.valid?
  end

  test "email should not be long" do
    @engineer.email = "a" * 245 + "@example.com
    asser_not @engineer.valid?
  end

  test "email should accept correct format" do
    valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @engineer.email = valids
      assert @engineer.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "should reject invalid addresses" do
    invalid_emails = %w[mashrur@example mashrur@example,com mashrur.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @engineer.email = invalids
      assert_not @engineer.valid?, "#{invalids.inspect} should be invalid"
    end
  end 
    
  test "email should be unique and case insensitive" do
    duplicate_engineer = @engineer.dup
    duplicate_engineer.email = @engineer.email.upcase
    @engineer.save
    assert_not duplicate_engineer.valid?
  end

  test "password should be present" do
    @engineer.password = @engineer.password_confirmation = " "
    assert_not @engineer.valid?
  end
  
  test "password should be atleast 5 character" do
    @engineer.password = @engineer.password_confirmation = "x" * 4
    assert_not @engineer.valid?
  end
end
