class LoansController < ApplicationController
  def index; end

  def complete
    @loan = Loan.find(params[:loan_id])
    @loan.returned_at = Time.zone.now

    @loan.save
    redirect_to @loan.member
    # @member = Member.find_by_id_number(params[:search])
  end
end
