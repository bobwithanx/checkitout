class MembersController < ApplicationController
  # before_action :force_json, only: :search
  def index
    @members = Member.active.includes('group', 'loans')
  end

  def search
    @members = Member.ransack(full_name_or_id_number_cont: params[:q]).result(distinct: true)

    if @members.size == 1
      redirect_to @members[0]
    end

    respond_to do |format|
      format.html {}
      format.json {
      }
    end
  end

  def history
    @member = Member.find_by_id params[:id]
    if @member.blank?
      flash[:danger] = "Member ID not found."
      redirect_to(welcome_index_path)
      return
    end

    @pagy, @loans = pagy(@member.loans.returned.includes([:item, :category]))
    @active_loans = @member.loans.active.size
    @completed_loans = @pagy.count

  end

  def show
    @member = Member.find_by_id params[:id]

    if @member.blank?
      flash[:danger] = "Member ID not found."
      redirect_to(welcome_index_path)
      return
    end

    @pagy, @loans = pagy(@member.active_loans.includes([:item, :category]))
    @active_loans = @pagy.count
    @completed_loans = @member.loans.returned.size
  end

  def undo_link
    view_context.link_to('undo', revert_version_path(@loan.versions.last), :method=> :post)
  end

  def items
    @member = Member.find_by_id params[:id]
    if @member.blank?
      flash[:danger] = "Member ID not found."
      redirect_to(welcome_index_path)
      return
    end
    @categories = Category.all
    @items = Item.available.includes(:category)
  end

  def borrow
    @member = Member.find(params[:member_id])
    if !@member
      flash[:danger] = "Could not find MemberID."
      return
    end
    @item = Item.find_by_inventory_tag(params[:inventory_tag].upcase)
    if !@item
      flash[:danger] = "Could not find Item."
    elsif @item.on_loan?
      flash[:danger] = "ERROR<p>Item is already borrowed.</p>"
    end
    if flash[:danger].blank?
      @loan = Loan.new
      @loan.member = @member
      @loan.item = @item
      if @loan.save
        flash[:success] = "Item borrowed. #{undo_link}"
      else
        flash[:danger] = "Error - item was not assigned."
      end
    end
    redirect_to @member
  end

  def return
    @loan = Loan.find(params[:id])
    @loan.returned_at = Time.now

    if @loan.save
      flash[:success] = "Item returned. #{undo_link}"
    else
      flash[:danger] = "ERROR<p>Item was not returned.</p>"
    end
    redirect_to @loan.member

    # render members_index
    # @member = Member.find_by_id_number(params[:search])
  end

  def new
    @member = Member.new
  end

  def edit
    @member = Member.find_by_id params[:id]
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to members_path
    else
      render 'new'
    end
  end

  def update
    @member = Member.find_by_id params[:id]

    if @member.update(member_params)
      redirect_to members_path
    else
      render 'edit'
    end
  end

  def destroy
    @member = Member.find_by_id params[:id]
    @member.destroy

    redirect_to members_path
  end

  private
  def force_json
    request.format = :json
  end

  def member_params
    params.require(:member).permit(:first_name, :last_name, :id_number, :group, :group_id)
  end
end
