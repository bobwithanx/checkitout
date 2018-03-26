require 'test_helper'

class LoanDecoratorTest < ActiveSupport::TestCase
  def setup
    @loan = Loan.new.extend LoanDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
