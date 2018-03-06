class LoansController < ApplicationController
  def index
    @loans = Loan.all
  end

  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy

    redirect_to loans_path
  end

  def complete
    @loan = Loan.find(params[:loan_id])
    @loan.returned_at = Time.zone.now

    @loan.save
    redirect_to @loan.member
    # @member = Member.find_by_id_number(params[:search])
  end
end
